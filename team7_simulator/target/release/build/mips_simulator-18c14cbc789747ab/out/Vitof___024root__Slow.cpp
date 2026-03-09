// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vitof.h for the primary calling header

#include "Vitof__pch.h"

void Vitof___024root___ctor_var_reset(Vitof___024root* vlSelf);

Vitof___024root::Vitof___024root(Vitof__Syms* symsp, const char* v__name)
    : VerilatedModule{v__name}
    , vlSymsp{symsp}
 {
    // Reset structure values
    Vitof___024root___ctor_var_reset(this);
}

void Vitof___024root::__Vconfigure(bool first) {
    (void)first;  // Prevent unused variable warning
}

Vitof___024root::~Vitof___024root() {
}
