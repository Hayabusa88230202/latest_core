// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Model implementation (design independent parts)

#include "Vfmul__pch.h"

//============================================================
// Constructors

Vfmul::Vfmul(VerilatedContext* _vcontextp__, const char* _vcname__)
    : VerilatedModel{*_vcontextp__}
    , vlSymsp{new Vfmul__Syms(contextp(), _vcname__, this)}
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

Vfmul::Vfmul(const char* _vcname__)
    : Vfmul(Verilated::threadContextp(), _vcname__)
{
}

//============================================================
// Destructor

Vfmul::~Vfmul() {
    delete vlSymsp;
}

//============================================================
// Evaluation function

#ifdef VL_DEBUG
void Vfmul___024root___eval_debug_assertions(Vfmul___024root* vlSelf);
#endif  // VL_DEBUG
void Vfmul___024root___eval_static(Vfmul___024root* vlSelf);
void Vfmul___024root___eval_initial(Vfmul___024root* vlSelf);
void Vfmul___024root___eval_settle(Vfmul___024root* vlSelf);
void Vfmul___024root___eval(Vfmul___024root* vlSelf);

void Vfmul::eval_step() {
    VL_DEBUG_IF(VL_DBG_MSGF("+++++TOP Evaluate Vfmul::eval_step\n"); );
#ifdef VL_DEBUG
    // Debug assertions
    Vfmul___024root___eval_debug_assertions(&(vlSymsp->TOP));
#endif  // VL_DEBUG
    vlSymsp->__Vm_deleter.deleteAll();
    if (VL_UNLIKELY(!vlSymsp->__Vm_didInit)) {
        vlSymsp->__Vm_didInit = true;
        VL_DEBUG_IF(VL_DBG_MSGF("+ Initial\n"););
        Vfmul___024root___eval_static(&(vlSymsp->TOP));
        Vfmul___024root___eval_initial(&(vlSymsp->TOP));
        Vfmul___024root___eval_settle(&(vlSymsp->TOP));
    }
    VL_DEBUG_IF(VL_DBG_MSGF("+ Eval\n"););
    Vfmul___024root___eval(&(vlSymsp->TOP));
    // Evaluate cleanup
    Verilated::endOfEval(vlSymsp->__Vm_evalMsgQp);
}

//============================================================
// Events and timing
bool Vfmul::eventsPending() { return false; }

uint64_t Vfmul::nextTimeSlot() {
    VL_FATAL_MT(__FILE__, __LINE__, "", "No delays in the design");
    return 0;
}

//============================================================
// Utilities

const char* Vfmul::name() const {
    return vlSymsp->name();
}

//============================================================
// Invoke final blocks

void Vfmul___024root___eval_final(Vfmul___024root* vlSelf);

VL_ATTR_COLD void Vfmul::final() {
    Vfmul___024root___eval_final(&(vlSymsp->TOP));
}

//============================================================
// Implementations of abstract methods from VerilatedModel

const char* Vfmul::hierName() const { return vlSymsp->name(); }
const char* Vfmul::modelName() const { return "Vfmul"; }
unsigned Vfmul::threads() const { return 1; }
void Vfmul::prepareClone() const { contextp()->prepareClone(); }
void Vfmul::atClone() const {
    contextp()->threadPoolpOnClone();
}
