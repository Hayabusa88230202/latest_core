// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See Vftoi.h for the primary calling header

#ifndef VERILATED_VFTOI___024ROOT_H_
#define VERILATED_VFTOI___024ROOT_H_  // guard

#include "verilated.h"


class Vftoi__Syms;

class alignas(VL_CACHE_LINE_BYTES) Vftoi___024root final : public VerilatedModule {
  public:

    // DESIGN SPECIFIC STATE
    VL_IN8(clk,0,0);
    VL_IN8(rst_n,0,0);
    VL_IN8(input_valid,0,0);
    VL_OUT8(out_valid,0,0);
    CData/*0:0*/ ftoi__DOT__s1_valid;
    CData/*0:0*/ ftoi__DOT__s1_sign;
    CData/*0:0*/ ftoi__DOT__s1_ovf;
    CData/*0:0*/ __Vtrigprevexpr___TOP__clk__0;
    VL_IN(in_f,31,0);
    VL_OUT(out_i,31,0);
    IData/*31:0*/ ftoi__DOT__s1_abs_int;
    IData/*31:0*/ __VactIterCount;
    VlUnpacked<QData/*63:0*/, 1> __VactTriggered;
    VlUnpacked<QData/*63:0*/, 1> __VnbaTriggered;

    // INTERNAL VARIABLES
    Vftoi__Syms* const vlSymsp;

    // CONSTRUCTORS
    Vftoi___024root(Vftoi__Syms* symsp, const char* v__name);
    ~Vftoi___024root();
    VL_UNCOPYABLE(Vftoi___024root);

    // INTERNAL METHODS
    void __Vconfigure(bool first);
};


#endif  // guard
