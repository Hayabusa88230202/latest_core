// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See Vfmul.h for the primary calling header

#ifndef VERILATED_VFMUL___024ROOT_H_
#define VERILATED_VFMUL___024ROOT_H_  // guard

#include "verilated.h"


class Vfmul__Syms;

class alignas(VL_CACHE_LINE_BYTES) Vfmul___024root final : public VerilatedModule {
  public:

    // DESIGN SPECIFIC STATE
    VL_IN8(clk,0,0);
    VL_IN8(rst_n,0,0);
    VL_IN8(input_valid,0,0);
    VL_OUT8(out_valid,0,0);
    CData/*0:0*/ fmul__DOT__c1_sign_res;
    CData/*0:0*/ fmul__DOT__c1_is_zero_or_sub;
    CData/*0:0*/ fmul__DOT__s1_sign_reg;
    CData/*0:0*/ fmul__DOT__s1_valid_reg;
    CData/*0:0*/ fmul__DOT__s1_zero_reg;
    CData/*0:0*/ fmul__DOT__s2_sign_reg;
    CData/*0:0*/ fmul__DOT__s2_sticky_reg;
    CData/*0:0*/ fmul__DOT__s2_valid_reg;
    CData/*0:0*/ fmul__DOT__s2_zero_reg;
    CData/*0:0*/ __VstlFirstIteration;
    CData/*0:0*/ __VicoFirstIteration;
    CData/*0:0*/ __Vtrigprevexpr___TOP__clk__0;
    SData/*9:0*/ fmul__DOT__c1_exp_temp;
    SData/*9:0*/ fmul__DOT__s1_exp_reg;
    SData/*9:0*/ fmul__DOT__s2_exp_reg;
    SData/*9:0*/ fmul__DOT__unnamedblk1__DOT__exp_checked;
    VL_IN(input_a,31,0);
    VL_IN(input_b,31,0);
    VL_OUT(result,31,0);
    IData/*26:0*/ fmul__DOT__s2_mant_reg;
    IData/*31:0*/ fmul__DOT__c3_result_comb;
    IData/*22:0*/ fmul__DOT__unnamedblk1__DOT__frac_final;
    IData/*31:0*/ __VactIterCount;
    QData/*47:0*/ fmul__DOT__c1_mant_prod;
    QData/*47:0*/ fmul__DOT__s1_prod_reg;
    VlUnpacked<QData/*63:0*/, 1> __VstlTriggered;
    VlUnpacked<QData/*63:0*/, 1> __VicoTriggered;
    VlUnpacked<QData/*63:0*/, 1> __VactTriggered;
    VlUnpacked<QData/*63:0*/, 1> __VnbaTriggered;

    // INTERNAL VARIABLES
    Vfmul__Syms* const vlSymsp;

    // CONSTRUCTORS
    Vfmul___024root(Vfmul__Syms* symsp, const char* v__name);
    ~Vfmul___024root();
    VL_UNCOPYABLE(Vfmul___024root);

    // INTERNAL METHODS
    void __Vconfigure(bool first);
};


#endif  // guard
