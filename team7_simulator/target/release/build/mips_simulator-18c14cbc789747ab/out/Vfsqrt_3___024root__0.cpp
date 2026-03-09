// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vfsqrt_3.h for the primary calling header

#include "Vfsqrt_3__pch.h"

#ifdef VL_DEBUG
VL_ATTR_COLD void Vfsqrt_3___024root___dump_triggers__act(const VlUnpacked<QData/*63:0*/, 1> &triggers, const std::string &tag);
#endif  // VL_DEBUG

void Vfsqrt_3___024root___eval_triggers__act(Vfsqrt_3___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfsqrt_3___024root___eval_triggers__act\n"); );
    Vfsqrt_3__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.__VactTriggered[0U] = (QData)((IData)(
                                                    ((((~ (IData)(vlSelfRef.rst_n)) 
                                                       & (IData)(vlSelfRef.__Vtrigprevexpr___TOP__rst_n__0)) 
                                                      << 1U) 
                                                     | ((IData)(vlSelfRef.clk) 
                                                        & (~ (IData)(vlSelfRef.__Vtrigprevexpr___TOP__clk__0))))));
    vlSelfRef.__Vtrigprevexpr___TOP__clk__0 = vlSelfRef.clk;
    vlSelfRef.__Vtrigprevexpr___TOP__rst_n__0 = vlSelfRef.rst_n;
#ifdef VL_DEBUG
    if (VL_UNLIKELY(vlSymsp->_vm_contextp__->debug())) {
        Vfsqrt_3___024root___dump_triggers__act(vlSelfRef.__VactTriggered, "act"s);
    }
#endif
}

bool Vfsqrt_3___024root___trigger_anySet__act(const VlUnpacked<QData/*63:0*/, 1> &in) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfsqrt_3___024root___trigger_anySet__act\n"); );
    // Locals
    IData/*31:0*/ n;
    // Body
    n = 0U;
    do {
        if (in[n]) {
            return (1U);
        }
        n = ((IData)(1U) + n);
    } while ((1U > n));
    return (0U);
}

void Vfsqrt_3___024root___nba_sequent__TOP__0(Vfsqrt_3___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfsqrt_3___024root___nba_sequent__TOP__0\n"); );
    Vfsqrt_3__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    IData/*24:0*/ fsqrt__DOT__a_x0_signed;
    fsqrt__DOT__a_x0_signed = 0;
    QData/*42:0*/ fsqrt__DOT__delta_mult;
    fsqrt__DOT__delta_mult = 0;
    QData/*47:0*/ fsqrt__DOT__P_out;
    fsqrt__DOT__P_out = 0;
    IData/*23:0*/ fsqrt__DOT__result_inner;
    fsqrt__DOT__result_inner = 0;
    CData/*2:0*/ __Vdly__fsqrt__DOT__is_zero_reg;
    __Vdly__fsqrt__DOT__is_zero_reg = 0;
    CData/*2:0*/ __Vdly__fsqrt__DOT__is_abnormal_reg;
    __Vdly__fsqrt__DOT__is_abnormal_reg = 0;
    // Body
    __Vdly__fsqrt__DOT__is_zero_reg = vlSelfRef.fsqrt__DOT__is_zero_reg;
    __Vdly__fsqrt__DOT__is_abnormal_reg = vlSelfRef.fsqrt__DOT__is_abnormal_reg;
    if (vlSelfRef.rst_n) {
        vlSelfRef.fsqrt__DOT__valid_reg = ((6U & ((IData)(vlSelfRef.fsqrt__DOT__valid_reg) 
                                                  << 1U)) 
                                           | (IData)(vlSelfRef.input_valid));
        __Vdly__fsqrt__DOT__is_zero_reg = ((6U & ((IData)(vlSelfRef.fsqrt__DOT__is_zero_reg) 
                                                  << 1U)) 
                                           | (IData)(
                                                     (0U 
                                                      == 
                                                      (0x7fffffffU 
                                                       & vlSelfRef.input_a))));
        __Vdly__fsqrt__DOT__is_abnormal_reg = ((6U 
                                                & ((IData)(vlSelfRef.fsqrt__DOT__is_abnormal_reg) 
                                                   << 1U)) 
                                               | (0xffU 
                                                  == 
                                                  (0x000000ffU 
                                                   & (vlSelfRef.input_a 
                                                      >> 0x00000017U))));
        vlSelfRef.fsqrt__DOT__exp_reg = vlSelfRef.fsqrt__DOT__exp_out;
        vlSelfRef.fsqrt__DOT__exp_reg_minus = (0x000000ffU 
                                               & ((IData)(vlSelfRef.fsqrt__DOT__exp_out) 
                                                  - (IData)(1U)));
        vlSelfRef.fsqrt__DOT__a_x0_reg = (0x00ffffffU 
                                          & (IData)(
                                                    (0x0000000000ffffffULL 
                                                     & (((QData)((IData)(vlSelfRef.fsqrt__DOT__a_fixed)) 
                                                         * (QData)((IData)(vlSelfRef.fsqrt__DOT__x_0))) 
                                                        >> 0x00000018U))));
        vlSelfRef.fsqrt__DOT__unnamedblk2__DOT__delta_24 
            = (0x00ffffffU & ((IData)(0x00400000U) 
                              - (IData)((0x0000000000ffffffULL 
                                         & (((QData)((IData)(vlSelfRef.fsqrt__DOT__a_fixed)) 
                                             * (QData)((IData)(vlSelfRef.fsqrt__DOT__x0_x0))) 
                                            >> 0x00000018U)))));
        vlSelfRef.fsqrt__DOT__delta_reg = (0x0003ffffU 
                                           & vlSelfRef.fsqrt__DOT__unnamedblk2__DOT__delta_24);
        vlSelfRef.result = ((2U & (IData)(vlSelfRef.fsqrt__DOT__is_zero_reg))
                             ? ((IData)(vlSelfRef.fsqrt__DOT__sign_reg) 
                                << 0x0000001fU) : (
                                                   (2U 
                                                    & (IData)(vlSelfRef.fsqrt__DOT__is_abnormal_reg))
                                                    ? 
                                                   (0x7f800000U 
                                                    | ((IData)(vlSelfRef.fsqrt__DOT__sign_reg) 
                                                       << 0x0000001fU))
                                                    : 
                                                   (((IData)(vlSelfRef.fsqrt__DOT__sign_reg) 
                                                     << 0x0000001fU) 
                                                    | (((IData)(vlSelfRef.fsqrt__DOT__exp_final) 
                                                        << 0x00000017U) 
                                                       | vlSelfRef.fsqrt__DOT__mant_final))));
        vlSelfRef.fsqrt__DOT__exp_out = (0x000000ffU 
                                         & ((IData)(0x7fU) 
                                            + (0x000000ffU 
                                               & (((0x000000ffU 
                                                    & (vlSelfRef.input_a 
                                                       >> 0x00000017U)) 
                                                   - (IData)(0x007fU)) 
                                                  >> 1U))));
        vlSelfRef.fsqrt__DOT__a_fixed = ((0x00800000U 
                                          & vlSelfRef.input_a)
                                          ? (0x00400000U 
                                             | (0x003fffffU 
                                                & (vlSelfRef.input_a 
                                                   >> 1U)))
                                          : (0x00800000U 
                                             | (0x007fffffU 
                                                & vlSelfRef.input_a)));
    } else {
        vlSelfRef.fsqrt__DOT__valid_reg = 0U;
        __Vdly__fsqrt__DOT__is_zero_reg = 0U;
        __Vdly__fsqrt__DOT__is_abnormal_reg = 0U;
        vlSelfRef.fsqrt__DOT__exp_reg = 0U;
        vlSelfRef.fsqrt__DOT__exp_reg_minus = 0U;
        vlSelfRef.fsqrt__DOT__a_x0_reg = 0U;
        vlSelfRef.fsqrt__DOT__delta_reg = 0U;
        vlSelfRef.result = 0U;
        vlSelfRef.fsqrt__DOT__exp_out = 0U;
        vlSelfRef.fsqrt__DOT__a_fixed = 0U;
    }
    vlSelfRef.fsqrt__DOT__is_zero_reg = __Vdly__fsqrt__DOT__is_zero_reg;
    vlSelfRef.fsqrt__DOT__is_abnormal_reg = __Vdly__fsqrt__DOT__is_abnormal_reg;
    vlSelfRef.out_valid = (1U & ((IData)(vlSelfRef.fsqrt__DOT__valid_reg) 
                                 >> 2U));
    fsqrt__DOT__a_x0_signed = vlSelfRef.fsqrt__DOT__a_x0_reg;
    fsqrt__DOT__delta_mult = (0x000007ffffffffffULL 
                              & VL_MULS_QQQ(43, (0x000007ffffffffffULL 
                                                 & VL_EXTENDS_QI(43,25, fsqrt__DOT__a_x0_signed)), 
                                            (0x000007ffffffffffULL 
                                             & VL_EXTENDS_QI(43,18, vlSelfRef.fsqrt__DOT__delta_reg))));
    fsqrt__DOT__P_out = (0x0000ffffffffffffULL & ((0x0000000000200000ULL 
                                                   | ((QData)((IData)(vlSelfRef.fsqrt__DOT__a_x0_reg)) 
                                                      << 0x00000017U)) 
                                                  + 
                                                  VL_EXTENDS_QQ(48,43, fsqrt__DOT__delta_mult)));
    fsqrt__DOT__result_inner = (0x00ffffffU & (IData)(
                                                      (fsqrt__DOT__P_out 
                                                       >> 0x16U)));
    if ((0x00800000U & fsqrt__DOT__result_inner)) {
        vlSelfRef.fsqrt__DOT__exp_final = vlSelfRef.fsqrt__DOT__exp_reg;
        vlSelfRef.fsqrt__DOT__mant_final = (0x007fffffU 
                                            & fsqrt__DOT__result_inner);
    } else {
        vlSelfRef.fsqrt__DOT__exp_final = vlSelfRef.fsqrt__DOT__exp_reg_minus;
        vlSelfRef.fsqrt__DOT__mant_final = (0x007ffffeU 
                                            & (fsqrt__DOT__result_inner 
                                               << 1U));
    }
    vlSelfRef.fsqrt__DOT__sign_reg = ((IData)(vlSelfRef.rst_n) 
                                      && (IData)(vlSelfRef.fsqrt__DOT__sign_out));
    vlSelfRef.fsqrt__DOT__sign_out = ((IData)(vlSelfRef.rst_n) 
                                      && (vlSelfRef.input_a 
                                          >> 0x0000001fU));
}

void Vfsqrt_3___024root___nba_sequent__TOP__1(Vfsqrt_3___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfsqrt_3___024root___nba_sequent__TOP__1\n"); );
    Vfsqrt_3__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.fsqrt__DOT__x_0 = vlSelfRef.fsqrt__DOT__lut
        [(0x000003ffU & (vlSelfRef.input_a >> 0x0000000eU))];
    vlSelfRef.fsqrt__DOT__x0_x0 = vlSelfRef.fsqrt__DOT__lut_sq
        [(0x000003ffU & (vlSelfRef.input_a >> 0x0000000eU))];
}

void Vfsqrt_3___024root___eval_nba(Vfsqrt_3___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfsqrt_3___024root___eval_nba\n"); );
    Vfsqrt_3__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((3ULL & vlSelfRef.__VnbaTriggered[0U])) {
        Vfsqrt_3___024root___nba_sequent__TOP__0(vlSelf);
    }
    if ((1ULL & vlSelfRef.__VnbaTriggered[0U])) {
        Vfsqrt_3___024root___nba_sequent__TOP__1(vlSelf);
    }
}

void Vfsqrt_3___024root___trigger_orInto__act(VlUnpacked<QData/*63:0*/, 1> &out, const VlUnpacked<QData/*63:0*/, 1> &in) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfsqrt_3___024root___trigger_orInto__act\n"); );
    // Locals
    IData/*31:0*/ n;
    // Body
    n = 0U;
    do {
        out[n] = (out[n] | in[n]);
        n = ((IData)(1U) + n);
    } while ((1U > n));
}

bool Vfsqrt_3___024root___eval_phase__act(Vfsqrt_3___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfsqrt_3___024root___eval_phase__act\n"); );
    Vfsqrt_3__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    Vfsqrt_3___024root___eval_triggers__act(vlSelf);
    Vfsqrt_3___024root___trigger_orInto__act(vlSelfRef.__VnbaTriggered, vlSelfRef.__VactTriggered);
    return (0U);
}

void Vfsqrt_3___024root___trigger_clear__act(VlUnpacked<QData/*63:0*/, 1> &out) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfsqrt_3___024root___trigger_clear__act\n"); );
    // Locals
    IData/*31:0*/ n;
    // Body
    n = 0U;
    do {
        out[n] = 0ULL;
        n = ((IData)(1U) + n);
    } while ((1U > n));
}

bool Vfsqrt_3___024root___eval_phase__nba(Vfsqrt_3___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfsqrt_3___024root___eval_phase__nba\n"); );
    Vfsqrt_3__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    CData/*0:0*/ __VnbaExecute;
    // Body
    __VnbaExecute = Vfsqrt_3___024root___trigger_anySet__act(vlSelfRef.__VnbaTriggered);
    if (__VnbaExecute) {
        Vfsqrt_3___024root___eval_nba(vlSelf);
        Vfsqrt_3___024root___trigger_clear__act(vlSelfRef.__VnbaTriggered);
    }
    return (__VnbaExecute);
}

void Vfsqrt_3___024root___eval(Vfsqrt_3___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfsqrt_3___024root___eval\n"); );
    Vfsqrt_3__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    IData/*31:0*/ __VnbaIterCount;
    // Body
    __VnbaIterCount = 0U;
    do {
        if (VL_UNLIKELY(((0x00000064U < __VnbaIterCount)))) {
#ifdef VL_DEBUG
            Vfsqrt_3___024root___dump_triggers__act(vlSelfRef.__VnbaTriggered, "nba"s);
#endif
            VL_FATAL_MT("sv/fsqrt_3.sv", 3, "", "NBA region did not converge after 100 tries");
        }
        __VnbaIterCount = ((IData)(1U) + __VnbaIterCount);
        vlSelfRef.__VactIterCount = 0U;
        do {
            if (VL_UNLIKELY(((0x00000064U < vlSelfRef.__VactIterCount)))) {
#ifdef VL_DEBUG
                Vfsqrt_3___024root___dump_triggers__act(vlSelfRef.__VactTriggered, "act"s);
#endif
                VL_FATAL_MT("sv/fsqrt_3.sv", 3, "", "Active region did not converge after 100 tries");
            }
            vlSelfRef.__VactIterCount = ((IData)(1U) 
                                         + vlSelfRef.__VactIterCount);
        } while (Vfsqrt_3___024root___eval_phase__act(vlSelf));
    } while (Vfsqrt_3___024root___eval_phase__nba(vlSelf));
}

#ifdef VL_DEBUG
void Vfsqrt_3___024root___eval_debug_assertions(Vfsqrt_3___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfsqrt_3___024root___eval_debug_assertions\n"); );
    Vfsqrt_3__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if (VL_UNLIKELY(((vlSelfRef.clk & 0xfeU)))) {
        Verilated::overWidthError("clk");
    }
    if (VL_UNLIKELY(((vlSelfRef.rst_n & 0xfeU)))) {
        Verilated::overWidthError("rst_n");
    }
    if (VL_UNLIKELY(((vlSelfRef.input_valid & 0xfeU)))) {
        Verilated::overWidthError("input_valid");
    }
}
#endif  // VL_DEBUG
