// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Symbol table internal header
//
// Internal details; most calling programs do not need this header,
// unless using verilator public meta comments.

#ifndef VERILATED_VFTOI__SYMS_H_
#define VERILATED_VFTOI__SYMS_H_  // guard

#include "verilated.h"

// INCLUDE MODEL CLASS

#include "Vftoi.h"

// INCLUDE MODULE CLASSES
#include "Vftoi___024root.h"

// SYMS CLASS (contains all model state)
class alignas(VL_CACHE_LINE_BYTES) Vftoi__Syms final : public VerilatedSyms {
  public:
    // INTERNAL STATE
    Vftoi* const __Vm_modelp;
    VlDeleter __Vm_deleter;
    bool __Vm_didInit = false;

    // MODULE INSTANCE STATE
    Vftoi___024root                TOP;

    // CONSTRUCTORS
    Vftoi__Syms(VerilatedContext* contextp, const char* namep, Vftoi* modelp);
    ~Vftoi__Syms();

    // METHODS
    const char* name() { return TOP.name(); }
};

#endif  // guard
