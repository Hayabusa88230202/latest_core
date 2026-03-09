// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Symbol table internal header
//
// Internal details; most calling programs do not need this header,
// unless using verilator public meta comments.

#ifndef VERILATED_VFSQRT_3__SYMS_H_
#define VERILATED_VFSQRT_3__SYMS_H_  // guard

#include "verilated.h"

// INCLUDE MODEL CLASS

#include "Vfsqrt_3.h"

// INCLUDE MODULE CLASSES
#include "Vfsqrt_3___024root.h"

// SYMS CLASS (contains all model state)
class alignas(VL_CACHE_LINE_BYTES) Vfsqrt_3__Syms final : public VerilatedSyms {
  public:
    // INTERNAL STATE
    Vfsqrt_3* const __Vm_modelp;
    VlDeleter __Vm_deleter;
    bool __Vm_didInit = false;

    // MODULE INSTANCE STATE
    Vfsqrt_3___024root             TOP;

    // CONSTRUCTORS
    Vfsqrt_3__Syms(VerilatedContext* contextp, const char* namep, Vfsqrt_3* modelp);
    ~Vfsqrt_3__Syms();

    // METHODS
    const char* name() { return TOP.name(); }
};

#endif  // guard
