// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Model implementation (design independent parts)

#include "Vftoi__pch.h"

//============================================================
// Constructors

Vftoi::Vftoi(VerilatedContext* _vcontextp__, const char* _vcname__)
    : VerilatedModel{*_vcontextp__}
    , vlSymsp{new Vftoi__Syms(contextp(), _vcname__, this)}
    , clk{vlSymsp->TOP.clk}
    , rst_n{vlSymsp->TOP.rst_n}
    , input_valid{vlSymsp->TOP.input_valid}
    , out_valid{vlSymsp->TOP.out_valid}
    , in_f{vlSymsp->TOP.in_f}
    , out_i{vlSymsp->TOP.out_i}
    , rootp{&(vlSymsp->TOP)}
{
    // Register model with the context
    contextp()->addModel(this);
}

Vftoi::Vftoi(const char* _vcname__)
    : Vftoi(Verilated::threadContextp(), _vcname__)
{
}

//============================================================
// Destructor

Vftoi::~Vftoi() {
    delete vlSymsp;
}

//============================================================
// Evaluation function

#ifdef VL_DEBUG
void Vftoi___024root___eval_debug_assertions(Vftoi___024root* vlSelf);
#endif  // VL_DEBUG
void Vftoi___024root___eval_static(Vftoi___024root* vlSelf);
void Vftoi___024root___eval_initial(Vftoi___024root* vlSelf);
void Vftoi___024root___eval_settle(Vftoi___024root* vlSelf);
void Vftoi___024root___eval(Vftoi___024root* vlSelf);

void Vftoi::eval_step() {
    VL_DEBUG_IF(VL_DBG_MSGF("+++++TOP Evaluate Vftoi::eval_step\n"); );
#ifdef VL_DEBUG
    // Debug assertions
    Vftoi___024root___eval_debug_assertions(&(vlSymsp->TOP));
#endif  // VL_DEBUG
    vlSymsp->__Vm_deleter.deleteAll();
    if (VL_UNLIKELY(!vlSymsp->__Vm_didInit)) {
        vlSymsp->__Vm_didInit = true;
        VL_DEBUG_IF(VL_DBG_MSGF("+ Initial\n"););
        Vftoi___024root___eval_static(&(vlSymsp->TOP));
        Vftoi___024root___eval_initial(&(vlSymsp->TOP));
        Vftoi___024root___eval_settle(&(vlSymsp->TOP));
    }
    VL_DEBUG_IF(VL_DBG_MSGF("+ Eval\n"););
    Vftoi___024root___eval(&(vlSymsp->TOP));
    // Evaluate cleanup
    Verilated::endOfEval(vlSymsp->__Vm_evalMsgQp);
}

//============================================================
// Events and timing
bool Vftoi::eventsPending() { return false; }

uint64_t Vftoi::nextTimeSlot() {
    VL_FATAL_MT(__FILE__, __LINE__, "", "No delays in the design");
    return 0;
}

//============================================================
// Utilities

const char* Vftoi::name() const {
    return vlSymsp->name();
}

//============================================================
// Invoke final blocks

void Vftoi___024root___eval_final(Vftoi___024root* vlSelf);

VL_ATTR_COLD void Vftoi::final() {
    Vftoi___024root___eval_final(&(vlSymsp->TOP));
}

//============================================================
// Implementations of abstract methods from VerilatedModel

const char* Vftoi::hierName() const { return vlSymsp->name(); }
const char* Vftoi::modelName() const { return "Vftoi"; }
unsigned Vftoi::threads() const { return 1; }
void Vftoi::prepareClone() const { contextp()->prepareClone(); }
void Vftoi::atClone() const {
    contextp()->threadPoolpOnClone();
}
