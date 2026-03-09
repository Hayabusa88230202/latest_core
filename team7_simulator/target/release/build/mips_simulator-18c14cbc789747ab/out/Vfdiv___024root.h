// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See Vfdiv.h for the primary calling header

#ifndef VERILATED_VFDIV___024ROOT_H_
#define VERILATED_VFDIV___024ROOT_H_  // guard

#include "verilated.h"


class Vfdiv__Syms;

class alignas(VL_CACHE_LINE_BYTES) Vfdiv___024root final : public VerilatedModule {
  public:

    // DESIGN SPECIFIC STATE
    VL_IN8(clk,0,0);
    VL_IN8(rst_n,0,0);
    VL_IN8(input_valid,0,0);
    VL_OUT8(out_valid,0,0);
    CData/*0:0*/ fdiv__DOT__st1_valid;
    CData/*0:0*/ fdiv__DOT__st1_sign;
    CData/*0:0*/ fdiv__DOT__st1_nan;
    CData/*7:0*/ fdiv__DOT__st1_exp_C;
    CData/*7:0*/ fdiv__DOT__st1_exp_N;
    CData/*7:0*/ fdiv__DOT__st1_exp_S;
    CData/*0:0*/ fdiv__DOT__st1_inf_C;
    CData/*0:0*/ fdiv__DOT__st1_inf_N;
    CData/*0:0*/ fdiv__DOT__st1_inf_S;
    CData/*0:0*/ fdiv__DOT__st1_zero_C;
    CData/*0:0*/ fdiv__DOT__st1_zero_N;
    CData/*0:0*/ fdiv__DOT__st1_zero_S;
    CData/*0:0*/ fdiv__DOT__shift_pred;
    CData/*0:0*/ fdiv__DOT__is_nan;
    CData/*0:0*/ fdiv__DOT__is_inf;
    CData/*0:0*/ fdiv__DOT__is_zero;
    CData/*0:0*/ fdiv__DOT__st2_valid;
    CData/*0:0*/ fdiv__DOT__st2_sign;
    CData/*0:0*/ fdiv__DOT__st2_nan;
    CData/*7:0*/ fdiv__DOT__st2_exp_C;
    CData/*7:0*/ fdiv__DOT__st2_exp_N;
    CData/*7:0*/ fdiv__DOT__st2_exp_S;
    CData/*0:0*/ fdiv__DOT__st2_inf_C;
    CData/*0:0*/ fdiv__DOT__st2_inf_N;
    CData/*0:0*/ fdiv__DOT__st2_inf_S;
    CData/*0:0*/ fdiv__DOT__st2_zero_C;
    CData/*0:0*/ fdiv__DOT__st2_zero_N;
    CData/*0:0*/ fdiv__DOT__st2_zero_S;
    CData/*0:0*/ __VstlFirstIteration;
    CData/*0:0*/ __VicoFirstIteration;
    CData/*0:0*/ __Vtrigprevexpr___TOP__clk__0;
    CData/*0:0*/ __Vtrigprevexpr___TOP__rst_n__0;
    SData/*10:0*/ fdiv__DOT__st1_m_b_10_0;
    SData/*10:0*/ fdiv__DOT__exp_N;
    VL_IN(input_a,31,0);
    VL_IN(input_b,31,0);
    VL_OUT(result,31,0);
    IData/*23:0*/ fdiv__DOT__m_a;
    IData/*23:0*/ fdiv__DOT__m_b;
    IData/*24:0*/ fdiv__DOT__st1_adjusted_a;
    IData/*24:0*/ fdiv__DOT__st2_adjusted_a;
    IData/*23:0*/ fdiv__DOT__st2_x1;
    IData/*31:0*/ __VactIterCount;
    QData/*47:0*/ fdiv__DOT__st1_y0_dy;
    QData/*48:0*/ fdiv__DOT__st1_bias;
    QData/*48:0*/ fdiv__DOT__st2_bias;
    QData/*48:0*/ fdiv__DOT__q_final;
    VlUnpacked<QData/*47:0*/, 4096> fdiv__DOT__lut;
    VlUnpacked<QData/*63:0*/, 1> __VstlTriggered;
    VlUnpacked<QData/*63:0*/, 1> __VicoTriggered;
    VlUnpacked<QData/*63:0*/, 1> __VactTriggered;
    VlUnpacked<QData/*63:0*/, 1> __VnbaTriggered;

    // INTERNAL VARIABLES
    Vfdiv__Syms* const vlSymsp;

    // CONSTRUCTORS
    Vfdiv___024root(Vfdiv__Syms* symsp, const char* v__name);
    ~Vfdiv___024root();
    VL_UNCOPYABLE(Vfdiv___024root);

    // INTERNAL METHODS
    void __Vconfigure(bool first);
};


#endif  // guard
