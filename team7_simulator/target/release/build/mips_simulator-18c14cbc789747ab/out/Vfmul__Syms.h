// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Symbol table internal header
//
// Internal details; most calling programs do not need this header,
// unless using verilator public meta comments.

#ifndef VERILATED_VFMUL__SYMS_H_
#define VERILATED_VFMUL__SYMS_H_  // guard

#include "verilated.h"

// INCLUDE MODEL CLASS

#include "Vfmul.h"

// INCLUDE MODULE CLASSES
#include "Vfmul___024root.h"

// SYMS CLASS (contains all model state)
class alignas(VL_CACHE_LINE_BYTES) Vfmul__Syms final : public VerilatedSyms {
  public:
    // INTERNAL STATE
    Vfmul* const __Vm_modelp;
    VlDeleter __Vm_deleter;
    bool __Vm_didInit = false;

    // MODULE INSTANCE STATE
    Vfmul___024root                TOP;

    // CONSTRUCTORS
    Vfmul__Syms(VerilatedContext* contextp, const char* namep, Vfmul* modelp);
    ~Vfmul__Syms();

    // METHODS
    const char* name() { return TOP.name(); }
};

#endif  // guard
