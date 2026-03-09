// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See Vfadd.h for the primary calling header

#ifndef VERILATED_VFADD___024ROOT_H_
#define VERILATED_VFADD___024ROOT_H_  // guard

#include "verilated.h"


class Vfadd__Syms;

class alignas(VL_CACHE_LINE_BYTES) Vfadd___024root final : public VerilatedModule {
  public:

    // DESIGN SPECIFIC STATE
    VL_IN8(clk,0,0);
    VL_IN8(rst_n,0,0);
    VL_IN8(input_valid,0,0);
    VL_OUT8(out_valid,0,0);
    CData/*0:0*/ fadd__DOT__c1_sticky;
    CData/*0:0*/ fadd__DOT__c1_effective_op;
    CData/*0:0*/ fadd__DOT__c1_sign_res;
    CData/*7:0*/ fadd__DOT__c1_exp_res;
    CData/*0:0*/ fadd__DOT__s1_effective_op_reg;
    CData/*0:0*/ fadd__DOT__s1_sign_res_reg;
    CData/*7:0*/ fadd__DOT__s1_exp_res_reg;
    CData/*0:0*/ fadd__DOT__s1_valid_reg;
    CData/*7:0*/ fadd__DOT__c2_exp_adjusted;
    CData/*2:0*/ fadd__DOT__c2_shift_remain;
    CData/*2:0*/ fadd__DOT__s2_shift_remain_reg;
    CData/*7:0*/ fadd__DOT__s2_exp_reg;
    CData/*0:0*/ fadd__DOT__s2_sign_reg;
    CData/*0:0*/ fadd__DOT__s2_valid_reg;
    CData/*7:0*/ fadd__DOT__exp_final;
    CData/*4:0*/ __Vfunc_fadd__DOT__count_leading_zeros__0__Vfuncout;
    CData/*0:0*/ __VstlFirstIteration;
    CData/*0:0*/ __VicoFirstIteration;
    CData/*0:0*/ __Vtrigprevexpr___TOP__clk__0;
    VL_IN(input_a,31,0);
    VL_IN(input_b,31,0);
    VL_OUT(result,31,0);
    IData/*31:0*/ fadd__DOT__c1_large;
    IData/*31:0*/ fadd__DOT__c1_small;
    IData/*26:0*/ fadd__DOT__c1_mant_large;
    IData/*26:0*/ fadd__DOT__c1_mant_small_shifted;
    IData/*26:0*/ fadd__DOT__s1_mant_large_reg;
    IData/*26:0*/ fadd__DOT__s1_mant_small_shifted_reg;
    IData/*27:0*/ fadd__DOT__c2_mant_shifted_1;
    IData/*27:0*/ fadd__DOT__s2_mant_reg;
    IData/*31:0*/ fadd__DOT__c3_result_comb;
    IData/*22:0*/ fadd__DOT__frac_final;
    IData/*23:0*/ fadd__DOT__frac_rounded;
    IData/*26:0*/ fadd__DOT__unnamedblk1__DOT__temp_shifted;
    IData/*31:0*/ __VactIterCount;
    VlUnpacked<QData/*63:0*/, 1> __VstlTriggered;
    VlUnpacked<QData/*63:0*/, 1> __VicoTriggered;
    VlUnpacked<QData/*63:0*/, 1> __VactTriggered;
    VlUnpacked<QData/*63:0*/, 1> __VnbaTriggered;

    // INTERNAL VARIABLES
    Vfadd__Syms* const vlSymsp;

    // CONSTRUCTORS
    Vfadd___024root(Vfadd__Syms* symsp, const char* v__name);
    ~Vfadd___024root();
    VL_UNCOPYABLE(Vfadd___024root);

    // INTERNAL METHODS
    void __Vconfigure(bool first);
};


#endif  // guard
