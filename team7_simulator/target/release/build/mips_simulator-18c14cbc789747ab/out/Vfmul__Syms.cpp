// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Symbol table implementation internals

#include "Vfmul__pch.h"
#include "Vfmul.h"
#include "Vfmul___024root.h"

// FUNCTIONS
Vfmul__Syms::~Vfmul__Syms()
{
}

Vfmul__Syms::Vfmul__Syms(VerilatedContext* contextp, const char* namep, Vfmul* modelp)
    : VerilatedSyms{contextp}
    // Setup internal state of the Syms class
    , __Vm_modelp{modelp}
    // Setup module instances
    , TOP{this, namep}
{
    // Check resources
    Verilated::stackCheck(318);
    // Configure time unit / time precision
    _vm_contextp__->timeunit(-12);
    _vm_contextp__->timeprecision(-12);
    // Setup each module's pointers to their submodules
    // Setup each module's pointer back to symbol table (for public functions)
    TOP.__Vconfigure(true);
}
