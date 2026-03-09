#include <stdint.h>
#include "Vfadd.h"
#include "Vfmul.h"
#include "Vfdiv.h"
#include "Vfsqrt_3.h"
#include "Vitof.h"
#include "Vftoi.h"

double sc_time_stamp() { return 0; }

extern "C" {
    // インスタンスのグローバルポインタ
    Vfadd* fadd_inst  = nullptr;
    Vfmul* fmul_inst  = nullptr;
    Vfdiv* fdiv_inst  = nullptr;
    Vfsqrt_3* fsqrt_inst = nullptr;
    Vitof* itof_inst  = nullptr;
    Vftoi* ftoi_inst  = nullptr;

    // Rustから最初に1回だけ呼ばれる初期化関数
    void hw_fpu_init() {
        fadd_inst  = new Vfadd();
        fmul_inst  = new Vfmul();
        fdiv_inst  = new Vfdiv();
        fsqrt_inst = new Vfsqrt_3();
        itof_inst  = new Vitof();
        ftoi_inst  = new Vftoi();
        
        // リセット
        fadd_inst->rst_n = 0; fadd_inst->clk = 0; fadd_inst->eval();
        fadd_inst->clk = 1; fadd_inst->eval();
        fadd_inst->rst_n = 1; fadd_inst->clk = 0; fadd_inst->eval();

        fmul_inst->rst_n = 0; fmul_inst->clk = 0; fmul_inst->eval();
        fmul_inst->clk = 1; fmul_inst->eval();
        fmul_inst->rst_n = 1; fmul_inst->clk = 0; fmul_inst->eval();

        fdiv_inst->rst_n = 0; fdiv_inst->clk = 0; fdiv_inst->eval();
        fdiv_inst->clk = 1; fdiv_inst->eval();
        fdiv_inst->rst_n = 1; fdiv_inst->clk = 0; fdiv_inst->eval();

        fsqrt_inst->rst_n = 0; fsqrt_inst->clk = 0; fsqrt_inst->eval();
        fsqrt_inst->clk = 1; fsqrt_inst->eval();
        fsqrt_inst->rst_n = 1; fsqrt_inst->clk = 0; fsqrt_inst->eval();

        itof_inst->rst_n = 0; itof_inst->clk = 0; itof_inst->eval();
        itof_inst->clk = 1; itof_inst->eval();
        itof_inst->rst_n = 1; itof_inst->clk = 0; itof_inst->eval();

        ftoi_inst->rst_n = 0; ftoi_inst->clk = 0; ftoi_inst->eval();
        ftoi_inst->clk = 1; ftoi_inst->eval();
        ftoi_inst->rst_n = 1; ftoi_inst->clk = 0; ftoi_inst->eval();
    }

    // faddの計算実行
    uint32_t hw_fadd_compute(uint32_t a, uint32_t b) {
        fadd_inst->input_a = a;
        fadd_inst->input_b = b;
        fadd_inst->input_valid = 1;
        
        fadd_inst->clk = 1; fadd_inst->eval();
        fadd_inst->clk = 0; fadd_inst->eval();
        fadd_inst->input_valid = 0;

        while (!fadd_inst->out_valid) {
            fadd_inst->clk = 1; fadd_inst->eval();
            fadd_inst->clk = 0; fadd_inst->eval();
        }

        return fadd_inst->result;
    }

    // fmulの計算実行 [cite: 80]
    uint32_t hw_fmul_compute(uint32_t a, uint32_t b) {
        fmul_inst->input_a = a;
        fmul_inst->input_b = b;
        fmul_inst->input_valid = 1;
        
        fmul_inst->clk = 1; fmul_inst->eval();
        fmul_inst->clk = 0; fmul_inst->eval();
        fmul_inst->input_valid = 0;

        while (!fmul_inst->out_valid) {
            fmul_inst->clk = 1; fmul_inst->eval();
            fmul_inst->clk = 0; fmul_inst->eval();
        }

        return fmul_inst->result;
    }

    // fdivの計算実行 [cite: 119]
    uint32_t hw_fdiv_compute(uint32_t a, uint32_t b) {
        fdiv_inst->input_a = a;
        fdiv_inst->input_b = b;
        fdiv_inst->input_valid = 1;
        
        fdiv_inst->clk = 1; fdiv_inst->eval();
        fdiv_inst->clk = 0; fdiv_inst->eval();
        fdiv_inst->input_valid = 0;

        while (!fdiv_inst->out_valid) {
            fdiv_inst->clk = 1; fdiv_inst->eval();
            fdiv_inst->clk = 0; fdiv_inst->eval();
        }

        return fdiv_inst->result;
    }

    // fsqrtの計算実行 [cite: 49]
    uint32_t hw_fsqrt_compute(uint32_t a) {
        fsqrt_inst->input_a = a;
        fsqrt_inst->input_valid = 1;
        
        fsqrt_inst->clk = 1; fsqrt_inst->eval();
        fsqrt_inst->clk = 0; fsqrt_inst->eval();
        fsqrt_inst->input_valid = 0;

        while (!fsqrt_inst->out_valid) {
            fsqrt_inst->clk = 1; fsqrt_inst->eval();
            fsqrt_inst->clk = 0; fsqrt_inst->eval();
        }

        return fsqrt_inst->result;
    }

    // itofの計算実行
    uint32_t hw_itof_compute(uint32_t a) {
        itof_inst->in_i = a;
        itof_inst->input_valid = 1;
        
        itof_inst->clk = 1; itof_inst->eval();
        itof_inst->clk = 0; itof_inst->eval();
        itof_inst->input_valid = 0;

        while (!itof_inst->out_valid) {
            itof_inst->clk = 1; itof_inst->eval();
            itof_inst->clk = 0; itof_inst->eval();
        }

        return itof_inst->out_f;
    }

    // ftoiの計算実行
    uint32_t hw_ftoi_compute(uint32_t a) {
        ftoi_inst->in_f = a;
        ftoi_inst->input_valid = 1;
        
        // 1サイクル目 (入力を取り込み)
        ftoi_inst->clk = 1; ftoi_inst->eval();
        ftoi_inst->clk = 0; ftoi_inst->eval();
        
        ftoi_inst->input_valid = 0;

        // 2サイクル目 (結果を出力レジスタへ)
        ftoi_inst->clk = 1; ftoi_inst->eval();
        ftoi_inst->clk = 0; ftoi_inst->eval();

        return ftoi_inst->out_i;
    }
}