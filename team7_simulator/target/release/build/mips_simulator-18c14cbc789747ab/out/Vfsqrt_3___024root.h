// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See Vfsqrt_3.h for the primary calling header

#ifndef VERILATED_VFSQRT_3___024ROOT_H_
#define VERILATED_VFSQRT_3___024ROOT_H_  // guard

#include "verilated.h"


class Vfsqrt_3__Syms;

class alignas(VL_CACHE_LINE_BYTES) Vfsqrt_3___024root final : public VerilatedModule {
  public:

    // DESIGN SPECIFIC STATE
    VL_IN8(clk,0,0);
    VL_IN8(rst_n,0,0);
    VL_IN8(input_valid,0,0);
    VL_OUT8(out_valid,0,0);
    CData/*2:0*/ fsqrt__DOT__valid_reg;
    CData/*2:0*/ fsqrt__DOT__is_zero_reg;
    CData/*2:0*/ fsqrt__DOT__is_abnormal_reg;
    CData/*7:0*/ fsqrt__DOT__exp_out;
    CData/*0:0*/ fsqrt__DOT__sign_out;
    CData/*7:0*/ fsqrt__DOT__exp_reg;
    CData/*7:0*/ fsqrt__DOT__exp_reg_minus;
    CData/*0:0*/ fsqrt__DOT__sign_reg;
    CData/*7:0*/ fsqrt__DOT__exp_final;
    CData/*0:0*/ __VstlFirstIteration;
    CData/*0:0*/ __Vtrigprevexpr___TOP__clk__0;
    CData/*0:0*/ __Vtrigprevexpr___TOP__rst_n__0;
    VL_IN(input_a,31,0);
    VL_OUT(result,31,0);
    IData/*23:0*/ fsqrt__DOT__a_fixed;
    IData/*23:0*/ fsqrt__DOT__x_0;
    IData/*23:0*/ fsqrt__DOT__x0_x0;
    IData/*23:0*/ fsqrt__DOT__a_x0_reg;
    IData/*17:0*/ fsqrt__DOT__delta_reg;
    IData/*22:0*/ fsqrt__DOT__mant_final;
    IData/*23:0*/ fsqrt__DOT__unnamedblk2__DOT__delta_24;
    IData/*31:0*/ __VactIterCount;
    VlUnpacked<IData/*23:0*/, 1024> fsqrt__DOT__lut;
    VlUnpacked<IData/*23:0*/, 1024> fsqrt__DOT__lut_sq;
    VlUnpacked<QData/*63:0*/, 1> __VstlTriggered;
    VlUnpacked<QData/*63:0*/, 1> __VactTriggered;
    VlUnpacked<QData/*63:0*/, 1> __VnbaTriggered;

    // INTERNAL VARIABLES
    Vfsqrt_3__Syms* const vlSymsp;

    // CONSTRUCTORS
    Vfsqrt_3___024root(Vfsqrt_3__Syms* symsp, const char* v__name);
    ~Vfsqrt_3___024root();
    VL_UNCOPYABLE(Vfsqrt_3___024root);

    // INTERNAL METHODS
    void __Vconfigure(bool first);
};


#endif  // guard
