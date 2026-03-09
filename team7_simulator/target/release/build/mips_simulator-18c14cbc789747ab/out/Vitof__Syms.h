// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Symbol table internal header
//
// Internal details; most calling programs do not need this header,
// unless using verilator public meta comments.

#ifndef VERILATED_VITOF__SYMS_H_
#define VERILATED_VITOF__SYMS_H_  // guard

#include "verilated.h"

// INCLUDE MODEL CLASS

#include "Vitof.h"

// INCLUDE MODULE CLASSES
#include "Vitof___024root.h"

// SYMS CLASS (contains all model state)
class alignas(VL_CACHE_LINE_BYTES) Vitof__Syms final : public VerilatedSyms {
  public:
    // INTERNAL STATE
    Vitof* const __Vm_modelp;
    VlDeleter __Vm_deleter;
    bool __Vm_didInit = false;

    // MODULE INSTANCE STATE
    Vitof___024root                TOP;

    // CONSTRUCTORS
    Vitof__Syms(VerilatedContext* contextp, const char* namep, Vitof* modelp);
    ~Vitof__Syms();

    // METHODS
    const char* name() { return TOP.name(); }
};

#endif  // guard
