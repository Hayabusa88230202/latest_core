extern "C" {
    pub fn hw_fpu_init();

    // 各計算関数
    pub fn hw_fadd_compute(a: u32, b: u32) -> u32;
    pub fn hw_fmul_compute(a: u32, b: u32) -> u32;
    pub fn hw_fdiv_compute(a: u32, b: u32) -> u32;
    pub fn hw_fsqrt_compute(a: u32) -> u32;
    pub fn hw_itof_compute(a: u32) -> u32;
    pub fn hw_ftoi_compute(a: u32) -> u32;
}

pub fn init() {
    unsafe {
        hw_fpu_init();
    }
}

/// fadd: 浮動小数点数の加算
pub fn hardware_fadd(a: f32, b: f32) -> f32 {
    unsafe {
        let result_bits = hw_fadd_compute(a.to_bits(), b.to_bits());
        f32::from_bits(result_bits)
    }
}

/// fmul: 浮動小数点数の乗算
pub fn hardware_fmul(a: f32, b: f32) -> f32 {
    unsafe {
        let result_bits = hw_fmul_compute(a.to_bits(), b.to_bits());
        f32::from_bits(result_bits)
    }
}

/// fdiv: 浮動小数点数の除算
pub fn hardware_fdiv(a: f32, b: f32) -> f32 {
    unsafe {
        let result_bits = hw_fdiv_compute(a.to_bits(), b.to_bits());
        f32::from_bits(result_bits)
    }
}

/// fsqrt: 浮動小数点数の平方根
pub fn hardware_fsqrt(a: f32) -> f32 {
    unsafe {
        let result_bits = hw_fsqrt_compute(a.to_bits());
        f32::from_bits(result_bits)
    }
}

/// itof: 整数(32bit)から浮動小数点数への変換
pub fn hardware_itof(a: u32) -> f32 {
    unsafe {
        let result_bits = hw_itof_compute(a);
        f32::from_bits(result_bits)
    }
}

/// ftoi: 浮動小数点数から整数(32bit)への変換
pub fn hardware_ftoi(a: f32) -> u32 {
    unsafe { hw_ftoi_compute(a.to_bits()) }
}
