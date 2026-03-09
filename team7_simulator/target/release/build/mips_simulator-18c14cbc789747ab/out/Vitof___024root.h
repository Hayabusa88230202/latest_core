// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See Vitof.h for the primary calling header

#ifndef VERILATED_VITOF___024ROOT_H_
#define VERILATED_VITOF___024ROOT_H_  // guard

#include "verilated.h"


class Vitof__Syms;

class alignas(VL_CACHE_LINE_BYTES) Vitof___024root final : public VerilatedModule {
  public:

    // DESIGN SPECIFIC STATE
    VL_IN8(clk,0,0);
    VL_IN8(rst_n,0,0);
    VL_IN8(input_valid,0,0);
    VL_OUT8(out_valid,0,0);
    CData/*0:0*/ itof__DOT__s1_sign;
    CData/*0:0*/ itof__DOT__s1_valid;
    CData/*4:0*/ itof__DOT__s2_lzc;
    CData/*0:0*/ itof__DOT__s2_sign;
    CData/*0:0*/ itof__DOT__s2_valid;
    CData/*7:0*/ itof__DOT__next_exp;
    CData/*0:0*/ itof__DOT__guard;
    CData/*0:0*/ itof__DOT__round;
    CData/*0:0*/ itof__DOT__sticky;
    CData/*0:0*/ itof__DOT__lsb;
    CData/*7:0*/ itof__DOT__unnamedblk1__DOT__temp_exp;
    CData/*0:0*/ __VstlFirstIteration;
    CData/*0:0*/ __Vtrigprevexpr___TOP__clk__0;
    VL_IN(in_i,31,0);
    VL_OUT(out_f,31,0);
    IData/*31:0*/ itof__DOT__s1_abs_i;
    IData/*31:0*/ itof__DOT__s2_abs_i;
    IData/*22:0*/ itof__DOT__next_frac;
    IData/*31:0*/ itof__DOT__shifted_mant;
    IData/*31:0*/ __VactIterCount;
    VlUnpacked<QData/*63:0*/, 1> __VstlTriggered;
    VlUnpacked<QData/*63:0*/, 1> __VactTriggered;
    VlUnpacked<QData/*63:0*/, 1> __VnbaTriggered;

    // INTERNAL VARIABLES
    Vitof__Syms* const vlSymsp;

    // CONSTRUCTORS
    Vitof___024root(Vitof__Syms* symsp, const char* v__name);
    ~Vitof___024root();
    VL_UNCOPYABLE(Vitof___024root);

    // INTERNAL METHODS
    void __Vconfigure(bool first);
};


#endif  // guard
