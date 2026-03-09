// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Symbol table internal header
//
// Internal details; most calling programs do not need this header,
// unless using verilator public meta comments.

#ifndef VERILATED_VFDIV__SYMS_H_
#define VERILATED_VFDIV__SYMS_H_  // guard

#include "verilated.h"

// INCLUDE MODEL CLASS

#include "Vfdiv.h"

// INCLUDE MODULE CLASSES
#include "Vfdiv___024root.h"

// SYMS CLASS (contains all model state)
class alignas(VL_CACHE_LINE_BYTES) Vfdiv__Syms final : public VerilatedSyms {
  public:
    // INTERNAL STATE
    Vfdiv* const __Vm_modelp;
    VlDeleter __Vm_deleter;
    bool __Vm_didInit = false;

    // MODULE INSTANCE STATE
    Vfdiv___024root                TOP;

    // CONSTRUCTORS
    Vfdiv__Syms(VerilatedContext* contextp, const char* namep, Vfdiv* modelp);
    ~Vfdiv__Syms();

    // METHODS
    const char* name() { return TOP.name(); }
};

#endif  // guard
