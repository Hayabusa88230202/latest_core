// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Model implementation (design independent parts)

#include "Vfadd__pch.h"

//============================================================
// Constructors

Vfadd::Vfadd(VerilatedContext* _vcontextp__, const char* _vcname__)
    : VerilatedModel{*_vcontextp__}
    , vlSymsp{new Vfadd__Syms(contextp(), _vcname__, this)}
    , clk{vlSymsp->TOP.clk}
    , rst_n{vlSymsp->TOP.rst_n}
    , input_valid{vlSymsp->TOP.input_valid}
    , out_valid{vlSymsp->TOP.out_valid}
    , input_a{vlSymsp->TOP.input_a}
    , input_b{vlSymsp->TOP.input_b}
    , result{vlSymsp->TOP.result}
    , rootp{&(vlSymsp->TOP)}
{
    // Register model with the context
    contextp()->addModel(this);
}

Vfadd::Vfadd(const char* _vcname__)
    : Vfadd(Verilated::threadContextp(), _vcname__)
{
}

//============================================================
// Destructor

Vfadd::~Vfadd() {
    delete vlSymsp;
}

//============================================================
// Evaluation function

#ifdef VL_DEBUG
void Vfadd___024root___eval_debug_assertions(Vfadd___024root* vlSelf);
#endif  // VL_DEBUG
void Vfadd___024root___eval_static(Vfadd___024root* vlSelf);
void Vfadd___024root___eval_initial(Vfadd___024root* vlSelf);
void Vfadd___024root___eval_settle(Vfadd___024root* vlSelf);
void Vfadd___024root___eval(Vfadd___024root* vlSelf);

void Vfadd::eval_step() {
    VL_DEBUG_IF(VL_DBG_MSGF("+++++TOP Evaluate Vfadd::eval_step\n"); );
#ifdef VL_DEBUG
    // Debug assertions
    Vfadd___024root___eval_debug_assertions(&(vlSymsp->TOP));
#endif  // VL_DEBUG
    vlSymsp->__Vm_deleter.deleteAll();
    if (VL_UNLIKELY(!vlSymsp->__Vm_didInit)) {
        vlSymsp->__Vm_didInit = true;
        VL_DEBUG_IF(VL_DBG_MSGF("+ Initial\n"););
        Vfadd___024root___eval_static(&(vlSymsp->TOP));
        Vfadd___024root___eval_initial(&(vlSymsp->TOP));
        Vfadd___024root___eval_settle(&(vlSymsp->TOP));
    }
    VL_DEBUG_IF(VL_DBG_MSGF("+ Eval\n"););
    Vfadd___024root___eval(&(vlSymsp->TOP));
    // Evaluate cleanup
    Verilated::endOfEval(vlSymsp->__Vm_evalMsgQp);
}

//============================================================
// Events and timing
bool Vfadd::eventsPending() { return false; }

uint64_t Vfadd::nextTimeSlot() {
    VL_FATAL_MT(__FILE__, __LINE__, "", "No delays in the design");
    return 0;
}

//============================================================
// Utilities

const char* Vfadd::name() const {
    return vlSymsp->name();
}

//============================================================
// Invoke final blocks

void Vfadd___024root___eval_final(Vfadd___024root* vlSelf);

VL_ATTR_COLD void Vfadd::final() {
    Vfadd___024root___eval_final(&(vlSymsp->TOP));
}

//============================================================
// Implementations of abstract methods from VerilatedModel

const char* Vfadd::hierName() const { return vlSymsp->name(); }
const char* Vfadd::modelName() const { return "Vfadd"; }
unsigned Vfadd::threads() const { return 1; }
void Vfadd::prepareClone() const { contextp()->prepareClone(); }
void Vfadd::atClone() const {
    contextp()->threadPoolpOnClone();
}
