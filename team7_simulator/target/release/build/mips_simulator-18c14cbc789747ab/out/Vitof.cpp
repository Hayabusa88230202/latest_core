// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Model implementation (design independent parts)

#include "Vitof__pch.h"

//============================================================
// Constructors

Vitof::Vitof(VerilatedContext* _vcontextp__, const char* _vcname__)
    : VerilatedModel{*_vcontextp__}
    , vlSymsp{new Vitof__Syms(contextp(), _vcname__, this)}
    , clk{vlSymsp->TOP.clk}
    , rst_n{vlSymsp->TOP.rst_n}
    , input_valid{vlSymsp->TOP.input_valid}
    , out_valid{vlSymsp->TOP.out_valid}
    , in_i{vlSymsp->TOP.in_i}
    , out_f{vlSymsp->TOP.out_f}
    , rootp{&(vlSymsp->TOP)}
{
    // Register model with the context
    contextp()->addModel(this);
}

Vitof::Vitof(const char* _vcname__)
    : Vitof(Verilated::threadContextp(), _vcname__)
{
}

//============================================================
// Destructor

Vitof::~Vitof() {
    delete vlSymsp;
}

//============================================================
// Evaluation function

#ifdef VL_DEBUG
void Vitof___024root___eval_debug_assertions(Vitof___024root* vlSelf);
#endif  // VL_DEBUG
void Vitof___024root___eval_static(Vitof___024root* vlSelf);
void Vitof___024root___eval_initial(Vitof___024root* vlSelf);
void Vitof___024root___eval_settle(Vitof___024root* vlSelf);
void Vitof___024root___eval(Vitof___024root* vlSelf);

void Vitof::eval_step() {
    VL_DEBUG_IF(VL_DBG_MSGF("+++++TOP Evaluate Vitof::eval_step\n"); );
#ifdef VL_DEBUG
    // Debug assertions
    Vitof___024root___eval_debug_assertions(&(vlSymsp->TOP));
#endif  // VL_DEBUG
    vlSymsp->__Vm_deleter.deleteAll();
    if (VL_UNLIKELY(!vlSymsp->__Vm_didInit)) {
        vlSymsp->__Vm_didInit = true;
        VL_DEBUG_IF(VL_DBG_MSGF("+ Initial\n"););
        Vitof___024root___eval_static(&(vlSymsp->TOP));
        Vitof___024root___eval_initial(&(vlSymsp->TOP));
        Vitof___024root___eval_settle(&(vlSymsp->TOP));
    }
    VL_DEBUG_IF(VL_DBG_MSGF("+ Eval\n"););
    Vitof___024root___eval(&(vlSymsp->TOP));
    // Evaluate cleanup
    Verilated::endOfEval(vlSymsp->__Vm_evalMsgQp);
}

//============================================================
// Events and timing
bool Vitof::eventsPending() { return false; }

uint64_t Vitof::nextTimeSlot() {
    VL_FATAL_MT(__FILE__, __LINE__, "", "No delays in the design");
    return 0;
}

//============================================================
// Utilities

const char* Vitof::name() const {
    return vlSymsp->name();
}

//============================================================
// Invoke final blocks

void Vitof___024root___eval_final(Vitof___024root* vlSelf);

VL_ATTR_COLD void Vitof::final() {
    Vitof___024root___eval_final(&(vlSymsp->TOP));
}

//============================================================
// Implementations of abstract methods from VerilatedModel

const char* Vitof::hierName() const { return vlSymsp->name(); }
const char* Vitof::modelName() const { return "Vitof"; }
unsigned Vitof::threads() const { return 1; }
void Vitof::prepareClone() const { contextp()->prepareClone(); }
void Vitof::atClone() const {
    contextp()->threadPoolpOnClone();
}
