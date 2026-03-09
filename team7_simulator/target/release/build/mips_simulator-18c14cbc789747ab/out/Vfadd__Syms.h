// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Symbol table internal header
//
// Internal details; most calling programs do not need this header,
// unless using verilator public meta comments.

#ifndef VERILATED_VFADD__SYMS_H_
#define VERILATED_VFADD__SYMS_H_  // guard

#include "verilated.h"

// INCLUDE MODEL CLASS

#include "Vfadd.h"

// INCLUDE MODULE CLASSES
#include "Vfadd___024root.h"

// SYMS CLASS (contains all model state)
class alignas(VL_CACHE_LINE_BYTES) Vfadd__Syms final : public VerilatedSyms {
  public:
    // INTERNAL STATE
    Vfadd* const __Vm_modelp;
    VlDeleter __Vm_deleter;
    bool __Vm_didInit = false;

    // MODULE INSTANCE STATE
    Vfadd___024root                TOP;

    // CONSTRUCTORS
    Vfadd__Syms(VerilatedContext* contextp, const char* namep, Vfadd* modelp);
    ~Vfadd__Syms();

    // METHODS
    const char* name() { return TOP.name(); }
};

#endif  // guard
