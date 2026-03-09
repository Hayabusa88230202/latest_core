// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Model implementation (design independent parts)

#include "Vfdiv__pch.h"

//============================================================
// Constructors

Vfdiv::Vfdiv(VerilatedContext* _vcontextp__, const char* _vcname__)
    : VerilatedModel{*_vcontextp__}
    , vlSymsp{new Vfdiv__Syms(contextp(), _vcname__, this)}
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

Vfdiv::Vfdiv(const char* _vcname__)
    : Vfdiv(Verilated::threadContextp(), _vcname__)
{
}

//============================================================
// Destructor

Vfdiv::~Vfdiv() {
    delete vlSymsp;
}

//============================================================
// Evaluation function

#ifdef VL_DEBUG
void Vfdiv___024root___eval_debug_assertions(Vfdiv___024root* vlSelf);
#endif  // VL_DEBUG
void Vfdiv___024root___eval_static(Vfdiv___024root* vlSelf);
void Vfdiv___024root___eval_initial(Vfdiv___024root* vlSelf);
void Vfdiv___024root___eval_settle(Vfdiv___024root* vlSelf);
void Vfdiv___024root___eval(Vfdiv___024root* vlSelf);

void Vfdiv::eval_step() {
    VL_DEBUG_IF(VL_DBG_MSGF("+++++TOP Evaluate Vfdiv::eval_step\n"); );
#ifdef VL_DEBUG
    // Debug assertions
    Vfdiv___024root___eval_debug_assertions(&(vlSymsp->TOP));
#endif  // VL_DEBUG
    vlSymsp->__Vm_deleter.deleteAll();
    if (VL_UNLIKELY(!vlSymsp->__Vm_didInit)) {
        vlSymsp->__Vm_didInit = true;
        VL_DEBUG_IF(VL_DBG_MSGF("+ Initial\n"););
        Vfdiv___024root___eval_static(&(vlSymsp->TOP));
        Vfdiv___024root___eval_initial(&(vlSymsp->TOP));
        Vfdiv___024root___eval_settle(&(vlSymsp->TOP));
    }
    VL_DEBUG_IF(VL_DBG_MSGF("+ Eval\n"););
    Vfdiv___024root___eval(&(vlSymsp->TOP));
    // Evaluate cleanup
    Verilated::endOfEval(vlSymsp->__Vm_evalMsgQp);
}

//============================================================
// Events and timing
bool Vfdiv::eventsPending() { return false; }

uint64_t Vfdiv::nextTimeSlot() {
    VL_FATAL_MT(__FILE__, __LINE__, "", "No delays in the design");
    return 0;
}

//============================================================
// Utilities

const char* Vfdiv::name() const {
    return vlSymsp->name();
}

//============================================================
// Invoke final blocks

void Vfdiv___024root___eval_final(Vfdiv___024root* vlSelf);

VL_ATTR_COLD void Vfdiv::final() {
    Vfdiv___024root___eval_final(&(vlSymsp->TOP));
}

//============================================================
// Implementations of abstract methods from VerilatedModel

const char* Vfdiv::hierName() const { return vlSymsp->name(); }
const char* Vfdiv::modelName() const { return "Vfdiv"; }
unsigned Vfdiv::threads() const { return 1; }
void Vfdiv::prepareClone() const { contextp()->prepareClone(); }
void Vfdiv::atClone() const {
    contextp()->threadPoolpOnClone();
}
