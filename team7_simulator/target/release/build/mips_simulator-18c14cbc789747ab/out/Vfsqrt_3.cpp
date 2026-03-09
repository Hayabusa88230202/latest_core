// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Model implementation (design independent parts)

#include "Vfsqrt_3__pch.h"

//============================================================
// Constructors

Vfsqrt_3::Vfsqrt_3(VerilatedContext* _vcontextp__, const char* _vcname__)
    : VerilatedModel{*_vcontextp__}
    , vlSymsp{new Vfsqrt_3__Syms(contextp(), _vcname__, this)}
    , clk{vlSymsp->TOP.clk}
    , rst_n{vlSymsp->TOP.rst_n}
    , input_valid{vlSymsp->TOP.input_valid}
    , out_valid{vlSymsp->TOP.out_valid}
    , input_a{vlSymsp->TOP.input_a}
    , result{vlSymsp->TOP.result}
    , rootp{&(vlSymsp->TOP)}
{
    // Register model with the context
    contextp()->addModel(this);
}

Vfsqrt_3::Vfsqrt_3(const char* _vcname__)
    : Vfsqrt_3(Verilated::threadContextp(), _vcname__)
{
}

//============================================================
// Destructor

Vfsqrt_3::~Vfsqrt_3() {
    delete vlSymsp;
}

//============================================================
// Evaluation function

#ifdef VL_DEBUG
void Vfsqrt_3___024root___eval_debug_assertions(Vfsqrt_3___024root* vlSelf);
#endif  // VL_DEBUG
void Vfsqrt_3___024root___eval_static(Vfsqrt_3___024root* vlSelf);
void Vfsqrt_3___024root___eval_initial(Vfsqrt_3___024root* vlSelf);
void Vfsqrt_3___024root___eval_settle(Vfsqrt_3___024root* vlSelf);
void Vfsqrt_3___024root___eval(Vfsqrt_3___024root* vlSelf);

void Vfsqrt_3::eval_step() {
    VL_DEBUG_IF(VL_DBG_MSGF("+++++TOP Evaluate Vfsqrt_3::eval_step\n"); );
#ifdef VL_DEBUG
    // Debug assertions
    Vfsqrt_3___024root___eval_debug_assertions(&(vlSymsp->TOP));
#endif  // VL_DEBUG
    vlSymsp->__Vm_deleter.deleteAll();
    if (VL_UNLIKELY(!vlSymsp->__Vm_didInit)) {
        vlSymsp->__Vm_didInit = true;
        VL_DEBUG_IF(VL_DBG_MSGF("+ Initial\n"););
        Vfsqrt_3___024root___eval_static(&(vlSymsp->TOP));
        Vfsqrt_3___024root___eval_initial(&(vlSymsp->TOP));
        Vfsqrt_3___024root___eval_settle(&(vlSymsp->TOP));
    }
    VL_DEBUG_IF(VL_DBG_MSGF("+ Eval\n"););
    Vfsqrt_3___024root___eval(&(vlSymsp->TOP));
    // Evaluate cleanup
    Verilated::endOfEval(vlSymsp->__Vm_evalMsgQp);
}

//============================================================
// Events and timing
bool Vfsqrt_3::eventsPending() { return false; }

uint64_t Vfsqrt_3::nextTimeSlot() {
    VL_FATAL_MT(__FILE__, __LINE__, "", "No delays in the design");
    return 0;
}

//============================================================
// Utilities

const char* Vfsqrt_3::name() const {
    return vlSymsp->name();
}

//============================================================
// Invoke final blocks

void Vfsqrt_3___024root___eval_final(Vfsqrt_3___024root* vlSelf);

VL_ATTR_COLD void Vfsqrt_3::final() {
    Vfsqrt_3___024root___eval_final(&(vlSymsp->TOP));
}

//============================================================
// Implementations of abstract methods from VerilatedModel

const char* Vfsqrt_3::hierName() const { return vlSymsp->name(); }
const char* Vfsqrt_3::modelName() const { return "Vfsqrt_3"; }
unsigned Vfsqrt_3::threads() const { return 1; }
void Vfsqrt_3::prepareClone() const { contextp()->prepareClone(); }
void Vfsqrt_3::atClone() const {
    contextp()->threadPoolpOnClone();
}
