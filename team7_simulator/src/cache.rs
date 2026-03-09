use std::fmt;

use crate::memory::{Memory, MemoryAddress, Word, MemoryError};

/// キャッシュラインのサイズ（バイト単位）
pub const CACHE_LINE_SIZE: usize = 16;

/// キャッシュのセット数
pub const CACHE_SETS: usize = 256;

/// キャッシュの連想度（ウェイ数）
pub const CACHE_WAYS: usize = 4;
/// キャッシュヒット時のアクセスレイテンシ（サイクル）
pub const CACHE_HIT_LATENCY: u64 = 2;
/// キャッシュミス時のアクセスレイテンシ（サイクル）
pub const CACHE_MISS_LATENCY: u64 = 62;

/// キャッシュライン
#[derive(Debug, Clone)]
struct CacheLine {
    /// 有効ビット
    valid: bool,
    /// ダーティビット（書き込み済みかどうか）
    dirty: bool,
    /// タグ
    tag: u32,
    /// データ
    data: [u8; CACHE_LINE_SIZE],
    /// アクセス時刻（LRU用）
    access_time: u64,
}

impl CacheLine {
    fn new() -> Self {
        Self {
            valid: false,
            dirty: false,
            tag: 0,
            data: [0; CACHE_LINE_SIZE],
            access_time: 0,
        }
    }
}

/// キャッシュセット
#[derive(Debug, Clone)]
struct CacheSet {
    lines: [CacheLine; CACHE_WAYS],
}

impl CacheSet {
    fn new() -> Self {
        Self {
            lines: [
                CacheLine::new(),
                CacheLine::new(),
                CacheLine::new(),
                CacheLine::new(),
            ],
        }
    }
}

/// キャッシュ統計情報
#[derive(Debug, Clone, Default)]
pub struct CacheStats {
    /// ヒット数
    pub hits: u64,
    /// ミス数
    pub misses: u64,
    /// 書き込みバック数
    pub writebacks: u64,
}

impl CacheStats {
    /// ヒット率を計算
    pub fn hit_rate(&self) -> f64 {
        let total = self.hits + self.misses;
        if total == 0 {
            0.0
        } else {
            self.hits as f64 / total as f64
        }
    }
}

/// キャッシュシステム
#[derive(Debug)]
pub struct Cache {
    /// キャッシュセット
    sets: [CacheSet; CACHE_SETS],
    /// 統計情報
    stats: CacheStats,
    /// アクセス時刻カウンタ
    access_counter: u64,
    /// キャッシュアクセス回数（1 read/write word = 1 access）
    total_accesses: u64,
    /// キャッシュアクセスに要した総レイテンシ（サイクル）
    total_latency_cycles: u64,
}

impl Cache {
    /// 新しいキャッシュシステムを作成
    pub fn new() -> Self {
        Self {
            sets: [(); CACHE_SETS].map(|_| CacheSet::new()),
            stats: CacheStats::default(),
            access_counter: 0,
            total_accesses: 0,
            total_latency_cycles: 0,
        }
    }

    fn record_access_latency(&mut self, is_hit: bool) {
        self.total_accesses += 1;
        self.total_latency_cycles += if is_hit {
            CACHE_HIT_LATENCY
        } else {
            CACHE_MISS_LATENCY
        };
    }

    fn decode_addr(&self, address: MemoryAddress) -> (u32, usize, usize) {
        // 16バイト(2^4)なら 4ビット
        let offset_bits = CACHE_LINE_SIZE.trailing_zeros();
        // 128セット(2^7)なら 7ビット、256セット(2^8)なら 8ビット
        let index_bits = CACHE_SETS.trailing_zeros();
        // オフセットを取り出すマスク (例: 4bitなら 0xF)
        let offset_mask = (1 << offset_bits) - 1;
        let offset = (address & offset_mask) as usize;
        // インデックスを取り出すマスク (例: 7bitなら 0x7F)
        let index_mask = (1 << index_bits) - 1;
        let index = ((address >> offset_bits) & index_mask) as usize;
        // 残りの上位ビットがタグ
        let tag = address >> (offset_bits + index_bits);
        (tag, index, offset)
    }

    /// 指定されたタグのキャッシュラインを検索
    fn find_line(&mut self, set_index: usize, tag: u32) -> Option<usize> {
        let set = &mut self.sets[set_index];
        for (i, line) in set.lines.iter_mut().enumerate() {
            if line.valid && line.tag == tag {
                line.access_time = self.access_counter;
                self.access_counter += 1;
                return Some(i);
            }
        }
        None
    }

    /// LRUでキャッシュラインを選択
    fn select_lru_line(&mut self, set_index: usize) -> usize {
        let set = &mut self.sets[set_index];
        let mut lru_index = 0;
        let mut oldest_time = set.lines[0].access_time;
        
        for (i, line) in set.lines.iter().enumerate() {
            if !line.valid {
                return i; // 無効なラインがあればそれを使用
            }
            if line.access_time < oldest_time {
                oldest_time = line.access_time;
                lru_index = i;
            }
        }
        
        lru_index
    }

    /// キャッシュラインをメモリに書き戻す
    #[allow(dead_code)]
    fn writeback_line(&mut self, memory: &mut Memory, set_index: usize, way_index: usize) -> Result<(), MemoryError> {
        let line = &self.sets[set_index].lines[way_index];
        if !line.dirty {
            return Ok(());
        }

        let base_address = ((line.tag * CACHE_SETS as u32 + set_index as u32) * CACHE_LINE_SIZE as u32) as MemoryAddress;
        
        for i in 0..CACHE_LINE_SIZE {
            memory.write_byte(base_address + i as u32, line.data[i])?;
        }
        
        self.stats.writebacks += 1;
        Ok(())
    }

    /// メモリからキャッシュラインを読み込む
    fn load_line(&mut self, memory: &Memory, set_index: usize, way_index: usize, tag: u32) -> Result<(), MemoryError> {
        let base_address = ((tag * CACHE_SETS as u32 + set_index as u32) * CACHE_LINE_SIZE as u32) as MemoryAddress;
        let line = &mut self.sets[set_index].lines[way_index];
        
        for i in 0..CACHE_LINE_SIZE {
            line.data[i] = memory.read_byte(base_address + i as u32)?;
        }
        
        line.valid = true;
        line.dirty = false;
        line.tag = tag;
        line.access_time = self.access_counter;
        self.access_counter += 1;
        
        Ok(())
    }

    
    // ワードを読み込む
    pub fn read_word(&mut self, memory: &mut Memory, address: MemoryAddress) -> Result<Word, MemoryError> {
        if address % 4 != 0 {
            return Err(MemoryError::AddressOutOfRange(address));
        }
        let (tag, set_index, offset) = self.decode_addr(address);
        let (way_index, is_hit) = if let Some(way_index) = self.find_line(set_index, tag) {
            self.stats.hits += 1; // 1ワードにつきヒット判定は1回だけ
            (way_index, true)
        } else {
            self.stats.misses += 1;
            let way_index = self.select_lru_line(set_index);
            
            if self.sets[set_index].lines[way_index].valid && self.sets[set_index].lines[way_index].dirty {
                self.writeback_line(memory, set_index, way_index)?;
            }
            self.load_line(memory, set_index, way_index, tag)?;
            (way_index, false)
        };
        self.record_access_latency(is_hit);
        
        // 確定したキャッシュラインから4バイト一気に読み出す
        let data = &self.sets[set_index].lines[way_index].data;
        let b0 = data[offset] as u32;
        let b1 = data[offset + 1] as u32;
        let b2 = data[offset + 2] as u32;
        let b3 = data[offset + 3] as u32;
        
        Ok((b3 << 24) | (b2 << 16) | (b1 << 8) | b0)
    }

    // ワードを書き込む
    pub fn write_word(&mut self, memory: &mut Memory, address: MemoryAddress, value: Word) -> Result<(), MemoryError> {
        if address % 4 != 0 {
            return Err(MemoryError::AddressOutOfRange(address));
        }
        let (tag, set_index, offset) = self.decode_addr(address);
        let (way_index, is_hit) = if let Some(way_index) = self.find_line(set_index, tag) {
            self.stats.hits += 1; // 1ワードにつきヒット判定は1回だけ
            (way_index, true)
        } else {
            self.stats.misses += 1;
            let way_index = self.select_lru_line(set_index);

            if self.sets[set_index].lines[way_index].valid && self.sets[set_index].lines[way_index].dirty {
                self.writeback_line(memory, set_index, way_index)?;
            }
            self.load_line(memory, set_index, way_index, tag)?;
            (way_index, false)
        };
        self.record_access_latency(is_hit);
        let line = &mut self.sets[set_index].lines[way_index];
        line.data[offset] = (value & 0xFF) as u8;
        line.data[offset + 1] = ((value >> 8) & 0xFF) as u8;
        line.data[offset + 2] = ((value >> 16) & 0xFF) as u8;
        line.data[offset + 3] = ((value >> 24) & 0xFF) as u8;
        line.dirty = true; // 上書きしたので必ずダーティにする
        Ok(())
    }

    /// キャッシュアクセス回数を取得
    pub fn get_total_accesses(&self) -> u64 {
        self.total_accesses
    }

    /// キャッシュアクセス総レイテンシ（サイクル）を取得
    pub fn get_total_latency_cycles(&self) -> u64 {
        self.total_latency_cycles
    }
    
    /// 統計情報を取得
    pub fn get_stats(&self) -> &CacheStats {
        &self.stats
    }
    
    /// 統計情報をリセット
    #[allow(dead_code)]
    pub fn reset_stats(&mut self) {
        self.stats = CacheStats::default();
        self.total_accesses = 0;
        self.total_latency_cycles = 0;
    }

    /// キャッシュをフラッシュ（全てのダーティラインをメモリに書き戻し）
    #[allow(dead_code)]
    pub fn flush(&mut self, memory: &mut Memory) -> Result<(), MemoryError> {
        // set_indexを使用し、self.setsの再借用を避ける
        for (set_index, set) in self.sets.iter_mut().enumerate() {
            // set_indexをu32にキャスト
            let set_index_u32 = set_index as u32; 

            for line in &mut set.lines {
                if line.valid && line.dirty {
                    // set_index_u32 を使用して base_address を計算
                    let base_address = ((line.tag * CACHE_SETS as u32 + 
                        set_index_u32) // <-- ここを修正
                        * CACHE_LINE_SIZE as u32) as MemoryAddress;
                    
                    for i in 0..CACHE_LINE_SIZE {
                        memory.write_byte(base_address + i as u32, line.data[i])?;
                    }
                    
                    line.dirty = false;
                    self.stats.writebacks += 1;
                }
            }
        }
        Ok(())
    }
}

impl fmt::Display for CacheStats {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "\n")?;
        write!(f, "総アクセス回数: {}\n", self.hits + self.misses)?;
        write!(f, "ヒット数: {}\n", self.hits)?;
        write!(f, "ミス数: {}\n", self.misses)?;
        write!(f, "ヒット率: {:.2}%\n", self.hit_rate() * 100.0)?;
        write!(f, "ライトバック数: {}\n", self.writebacks)
    }
}
