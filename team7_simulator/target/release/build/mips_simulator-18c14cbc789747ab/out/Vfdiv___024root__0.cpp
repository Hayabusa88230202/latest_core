// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vfdiv.h for the primary calling header

#include "Vfdiv__pch.h"

#ifdef VL_DEBUG
VL_ATTR_COLD void Vfdiv___024root___dump_triggers__ico(const VlUnpacked<QData/*63:0*/, 1> &triggers, const std::string &tag);
#endif  // VL_DEBUG

void Vfdiv___024root___eval_triggers__ico(Vfdiv___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfdiv___024root___eval_triggers__ico\n"); );
    Vfdiv__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.__VicoTriggered[0U] = ((0xfffffffffffffffeULL 
                                      & vlSelfRef.__VicoTriggered
                                      [0U]) | (IData)((IData)(vlSelfRef.__VicoFirstIteration)));
    vlSelfRef.__VicoFirstIteration = 0U;
#ifdef VL_DEBUG
    if (VL_UNLIKELY(vlSymsp->_vm_contextp__->debug())) {
        Vfdiv___024root___dump_triggers__ico(vlSelfRef.__VicoTriggered, "ico"s);
    }
#endif
}

bool Vfdiv___024root___trigger_anySet__ico(const VlUnpacked<QData/*63:0*/, 1> &in) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfdiv___024root___trigger_anySet__ico\n"); );
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

void Vfdiv___024root___ico_sequent__TOP__0(Vfdiv___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfdiv___024root___ico_sequent__TOP__0\n"); );
    Vfdiv__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    CData/*0:0*/ fdiv__DOT__a_is_inf;
    fdiv__DOT__a_is_inf = 0;
    CData/*0:0*/ fdiv__DOT__b_is_inf;
    fdiv__DOT__b_is_inf = 0;
    SData/*10:0*/ fdiv__DOT__raw_exp;
    fdiv__DOT__raw_exp = 0;
    // Body
    fdiv__DOT__raw_exp = (0x000007ffU & ((IData)(0x007fU) 
                                         + (((0U != 
                                              (0x000000ffU 
                                               & (vlSelfRef.input_a 
                                                  >> 0x00000017U)))
                                              ? (0x000000ffU 
                                                 & (vlSelfRef.input_a 
                                                    >> 0x00000017U))
                                              : 1U) 
                                            - ((0U 
                                                != 
                                                (0x000000ffU 
                                                 & (vlSelfRef.input_b 
                                                    >> 0x00000017U)))
                                                ? (0x000000ffU 
                                                   & (vlSelfRef.input_b 
                                                      >> 0x00000017U))
                                                : 1U))));
    vlSelfRef.fdiv__DOT__m_a = ((0U != (0x000000ffU 
                                        & (vlSelfRef.input_a 
                                           >> 0x00000017U)))
                                 ? (0x00800000U | (0x007fffffU 
                                                   & vlSelfRef.input_a))
                                 : (0x007fffffU & vlSelfRef.input_a));
    vlSelfRef.fdiv__DOT__m_b = ((0U != (0x000000ffU 
                                        & (vlSelfRef.input_b 
                                           >> 0x00000017U)))
                                 ? (0x00800000U | (0x007fffffU 
                                                   & vlSelfRef.input_b))
                                 : (0x007fffffU & vlSelfRef.input_b));
    fdiv__DOT__a_is_inf = (IData)((0x7f800000U == (0x7fffffffU 
                                                   & vlSelfRef.input_a)));
    fdiv__DOT__b_is_inf = (IData)((0x7f800000U == (0x7fffffffU 
                                                   & vlSelfRef.input_b)));
    vlSelfRef.fdiv__DOT__shift_pred = (vlSelfRef.fdiv__DOT__m_a 
                                       >= vlSelfRef.fdiv__DOT__m_b);
    vlSelfRef.fdiv__DOT__is_inf = ((IData)(fdiv__DOT__a_is_inf) 
                                   | (0U == (0x7fffffffU 
                                             & vlSelfRef.input_b)));
    vlSelfRef.fdiv__DOT__is_zero = ((0U == (0x7fffffffU 
                                            & vlSelfRef.input_a)) 
                                    | (IData)(fdiv__DOT__b_is_inf));
    vlSelfRef.fdiv__DOT__is_nan = ((IData)(((0x7f800000U 
                                             == (0x7f800000U 
                                                 & vlSelfRef.input_a)) 
                                            & (0U != 
                                               (0x007fffffU 
                                                & vlSelfRef.input_a)))) 
                                   | ((IData)(((0x7f800000U 
                                                == 
                                                (0x7f800000U 
                                                 & vlSelfRef.input_b)) 
                                               & (0U 
                                                  != 
                                                  (0x007fffffU 
                                                   & vlSelfRef.input_b)))) 
                                      | (((0U == (0x7fffffffU 
                                                  & vlSelfRef.input_a)) 
                                          & (0U == 
                                             (0x7fffffffU 
                                              & vlSelfRef.input_b))) 
                                         | ((IData)(fdiv__DOT__a_is_inf) 
                                            & (IData)(fdiv__DOT__b_is_inf)))));
    vlSelfRef.fdiv__DOT__exp_N = (0x000007ffU & ((IData)(vlSelfRef.fdiv__DOT__shift_pred)
                                                  ? (IData)(fdiv__DOT__raw_exp)
                                                  : 
                                                 ((IData)(fdiv__DOT__raw_exp) 
                                                  - (IData)(1U))));
}

void Vfdiv___024root___eval_ico(Vfdiv___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfdiv___024root___eval_ico\n"); );
    Vfdiv__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((1ULL & vlSelfRef.__VicoTriggered[0U])) {
        Vfdiv___024root___ico_sequent__TOP__0(vlSelf);
    }
}

bool Vfdiv___024root___eval_phase__ico(Vfdiv___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfdiv___024root___eval_phase__ico\n"); );
    Vfdiv__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    CData/*0:0*/ __VicoExecute;
    // Body
    Vfdiv___024root___eval_triggers__ico(vlSelf);
    __VicoExecute = Vfdiv___024root___trigger_anySet__ico(vlSelfRef.__VicoTriggered);
    if (__VicoExecute) {
        Vfdiv___024root___eval_ico(vlSelf);
    }
    return (__VicoExecute);
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vfdiv___024root___dump_triggers__act(const VlUnpacked<QData/*63:0*/, 1> &triggers, const std::string &tag);
#endif  // VL_DEBUG

void Vfdiv___024root___eval_triggers__act(Vfdiv___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfdiv___024root___eval_triggers__act\n"); );
    Vfdiv__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
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
        Vfdiv___024root___dump_triggers__act(vlSelfRef.__VactTriggered, "act"s);
    }
#endif
}

bool Vfdiv___024root___trigger_anySet__act(const VlUnpacked<QData/*63:0*/, 1> &in) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfdiv___024root___trigger_anySet__act\n"); );
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

void Vfdiv___024root___nba_sequent__TOP__0(Vfdiv___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfdiv___024root___nba_sequent__TOP__0\n"); );
    Vfdiv__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if (vlSelfRef.rst_n) {
        vlSelfRef.fdiv__DOT__st2_bias = vlSelfRef.fdiv__DOT__st1_bias;
        vlSelfRef.fdiv__DOT__st2_adjusted_a = vlSelfRef.fdiv__DOT__st1_adjusted_a;
        vlSelfRef.fdiv__DOT__st2_x1 = (0x00ffffffU 
                                       & (IData)((0x0000000001ffffffULL 
                                                  & ((((QData)((IData)(
                                                                       (0x00ffffffU 
                                                                        & (IData)(
                                                                                (vlSelfRef.fdiv__DOT__st1_y0_dy 
                                                                                >> 0x00000018U))))) 
                                                       << 0x00000017U) 
                                                      - 
                                                      (0x00000007ffffffffULL 
                                                       & ((QData)((IData)(
                                                                          (0x00ffffffU 
                                                                           & (IData)(vlSelfRef.fdiv__DOT__st1_y0_dy)))) 
                                                          * (QData)((IData)(vlSelfRef.fdiv__DOT__st1_m_b_10_0))))) 
                                                     >> 0x00000017U))));
        if (vlSelfRef.fdiv__DOT__st2_valid) {
            vlSelfRef.result = ((IData)(vlSelfRef.fdiv__DOT__st2_nan)
                                 ? 0x7fc00000U : ((
                                                   (1U 
                                                    & (IData)(
                                                              (vlSelfRef.fdiv__DOT__q_final 
                                                               >> 0x0000002fU)))
                                                    ? (IData)(vlSelfRef.fdiv__DOT__st2_inf_C)
                                                    : 
                                                   ((1U 
                                                     & (IData)(
                                                               (vlSelfRef.fdiv__DOT__q_final 
                                                                >> 0x0000002eU)))
                                                     ? (IData)(vlSelfRef.fdiv__DOT__st2_inf_N)
                                                     : (IData)(vlSelfRef.fdiv__DOT__st2_inf_S)))
                                                   ? 
                                                  (0x7f800000U 
                                                   | ((IData)(vlSelfRef.fdiv__DOT__st2_sign) 
                                                      << 0x0000001fU))
                                                   : 
                                                  (((1U 
                                                     & (IData)(
                                                               (vlSelfRef.fdiv__DOT__q_final 
                                                                >> 0x0000002fU)))
                                                     ? (IData)(vlSelfRef.fdiv__DOT__st2_zero_C)
                                                     : 
                                                    ((1U 
                                                      & (IData)(
                                                                (vlSelfRef.fdiv__DOT__q_final 
                                                                 >> 0x0000002eU)))
                                                      ? (IData)(vlSelfRef.fdiv__DOT__st2_zero_N)
                                                      : (IData)(vlSelfRef.fdiv__DOT__st2_zero_S)))
                                                    ? 
                                                   ((IData)(vlSelfRef.fdiv__DOT__st2_sign) 
                                                    << 0x0000001fU)
                                                    : 
                                                   (((IData)(vlSelfRef.fdiv__DOT__st2_sign) 
                                                     << 0x0000001fU) 
                                                    | ((((1U 
                                                          & (IData)(
                                                                    (vlSelfRef.fdiv__DOT__q_final 
                                                                     >> 0x0000002fU)))
                                                          ? (IData)(vlSelfRef.fdiv__DOT__st2_exp_C)
                                                          : 
                                                         ((1U 
                                                           & (IData)(
                                                                     (vlSelfRef.fdiv__DOT__q_final 
                                                                      >> 0x0000002eU)))
                                                           ? (IData)(vlSelfRef.fdiv__DOT__st2_exp_N)
                                                           : (IData)(vlSelfRef.fdiv__DOT__st2_exp_S))) 
                                                        << 0x00000017U) 
                                                       | (0x007fffffU 
                                                          & ((1U 
                                                              & (IData)(
                                                                        (vlSelfRef.fdiv__DOT__q_final 
                                                                         >> 0x0000002fU)))
                                                              ? (IData)(
                                                                        (vlSelfRef.fdiv__DOT__q_final 
                                                                         >> 0x00000018U))
                                                              : 
                                                             ((1U 
                                                               & (IData)(
                                                                         (vlSelfRef.fdiv__DOT__q_final 
                                                                          >> 0x0000002eU)))
                                                               ? (IData)(
                                                                         (vlSelfRef.fdiv__DOT__q_final 
                                                                          >> 0x00000017U))
                                                               : (IData)(
                                                                         (vlSelfRef.fdiv__DOT__q_final 
                                                                          >> 0x00000016U))))))))));
        }
        vlSelfRef.fdiv__DOT__st1_bias = ((0U == (0x007fffffU 
                                                 & vlSelfRef.fdiv__DOT__m_b))
                                          ? 0ULL : 0x00000000017fffffULL);
        vlSelfRef.fdiv__DOT__st1_adjusted_a = ((IData)(vlSelfRef.fdiv__DOT__shift_pred)
                                                ? vlSelfRef.fdiv__DOT__m_a
                                                : (vlSelfRef.fdiv__DOT__m_a 
                                                   << 1U));
        vlSelfRef.fdiv__DOT__st1_m_b_10_0 = (0x000007ffU 
                                             & vlSelfRef.fdiv__DOT__m_b);
        vlSelfRef.fdiv__DOT__st2_exp_C = vlSelfRef.fdiv__DOT__st1_exp_C;
        vlSelfRef.fdiv__DOT__st2_exp_N = vlSelfRef.fdiv__DOT__st1_exp_N;
        vlSelfRef.fdiv__DOT__st2_exp_S = vlSelfRef.fdiv__DOT__st1_exp_S;
        vlSelfRef.fdiv__DOT__st1_exp_C = (0x000000ffU 
                                          & ((IData)(1U) 
                                             + (IData)(vlSelfRef.fdiv__DOT__exp_N)));
        vlSelfRef.fdiv__DOT__st1_exp_N = (0x000000ffU 
                                          & (IData)(vlSelfRef.fdiv__DOT__exp_N));
        vlSelfRef.fdiv__DOT__st1_exp_S = (0x000000ffU 
                                          & ((IData)(vlSelfRef.fdiv__DOT__exp_N) 
                                             - (IData)(1U)));
    } else {
        vlSelfRef.fdiv__DOT__st2_bias = 0ULL;
        vlSelfRef.fdiv__DOT__st2_adjusted_a = 0U;
        vlSelfRef.fdiv__DOT__st2_x1 = 0U;
        vlSelfRef.result = 0U;
        vlSelfRef.fdiv__DOT__st1_bias = 0ULL;
        vlSelfRef.fdiv__DOT__st1_adjusted_a = 0U;
        vlSelfRef.fdiv__DOT__st1_m_b_10_0 = 0U;
        vlSelfRef.fdiv__DOT__st2_exp_C = 0U;
        vlSelfRef.fdiv__DOT__st2_exp_N = 0U;
        vlSelfRef.fdiv__DOT__st2_exp_S = 0U;
        vlSelfRef.fdiv__DOT__st1_exp_C = 0U;
        vlSelfRef.fdiv__DOT__st1_exp_N = 0U;
        vlSelfRef.fdiv__DOT__st1_exp_S = 0U;
    }
    vlSelfRef.out_valid = ((IData)(vlSelfRef.rst_n) 
                           && (IData)(vlSelfRef.fdiv__DOT__st2_valid));
    vlSelfRef.fdiv__DOT__q_final = (0x0001ffffffffffffULL 
                                    & (((QData)((IData)(
                                                        (vlSelfRef.fdiv__DOT__st2_adjusted_a 
                                                         * 
                                                         (0x0000007fU 
                                                          & (vlSelfRef.fdiv__DOT__st2_x1 
                                                             >> 0x00000011U))))) 
                                        << 0x00000011U) 
                                       + ((0x000003ffffffffffULL 
                                           & ((QData)((IData)(vlSelfRef.fdiv__DOT__st2_adjusted_a)) 
                                              * (QData)((IData)(
                                                                (0x0001ffffU 
                                                                 & vlSelfRef.fdiv__DOT__st2_x1))))) 
                                          + vlSelfRef.fdiv__DOT__st2_bias)));
    vlSelfRef.fdiv__DOT__st2_valid = ((IData)(vlSelfRef.rst_n) 
                                      && (IData)(vlSelfRef.fdiv__DOT__st1_valid));
    vlSelfRef.fdiv__DOT__st2_sign = ((IData)(vlSelfRef.rst_n) 
                                     && (IData)(vlSelfRef.fdiv__DOT__st1_sign));
    vlSelfRef.fdiv__DOT__st2_nan = ((IData)(vlSelfRef.rst_n) 
                                    && (IData)(vlSelfRef.fdiv__DOT__st1_nan));
    vlSelfRef.fdiv__DOT__st2_inf_C = ((IData)(vlSelfRef.rst_n) 
                                      && (IData)(vlSelfRef.fdiv__DOT__st1_inf_C));
    vlSelfRef.fdiv__DOT__st2_inf_N = ((IData)(vlSelfRef.rst_n) 
                                      && (IData)(vlSelfRef.fdiv__DOT__st1_inf_N));
    vlSelfRef.fdiv__DOT__st2_inf_S = ((IData)(vlSelfRef.rst_n) 
                                      && (IData)(vlSelfRef.fdiv__DOT__st1_inf_S));
    vlSelfRef.fdiv__DOT__st2_zero_C = ((IData)(vlSelfRef.rst_n) 
                                       && (IData)(vlSelfRef.fdiv__DOT__st1_zero_C));
    vlSelfRef.fdiv__DOT__st2_zero_N = ((IData)(vlSelfRef.rst_n) 
                                       && (IData)(vlSelfRef.fdiv__DOT__st1_zero_N));
    vlSelfRef.fdiv__DOT__st2_zero_S = ((IData)(vlSelfRef.rst_n) 
                                       && (IData)(vlSelfRef.fdiv__DOT__st1_zero_S));
    vlSelfRef.fdiv__DOT__st1_valid = ((IData)(vlSelfRef.rst_n) 
                                      && (IData)(vlSelfRef.input_valid));
    vlSelfRef.fdiv__DOT__st1_sign = ((IData)(vlSelfRef.rst_n) 
                                     && ((vlSelfRef.input_a 
                                          ^ vlSelfRef.input_b) 
                                         >> 0x0000001fU));
    vlSelfRef.fdiv__DOT__st1_nan = ((IData)(vlSelfRef.rst_n) 
                                    && (IData)(vlSelfRef.fdiv__DOT__is_nan));
    vlSelfRef.fdiv__DOT__st1_inf_C = ((IData)(vlSelfRef.rst_n) 
                                      && (((IData)(vlSelfRef.fdiv__DOT__is_inf) 
                                           & (~ (IData)(vlSelfRef.fdiv__DOT__is_nan))) 
                                          | VL_LTES_III(11, 0x00ffU, 
                                                        (0x000007ffU 
                                                         & ((IData)(1U) 
                                                            + (IData)(vlSelfRef.fdiv__DOT__exp_N))))));
    vlSelfRef.fdiv__DOT__st1_inf_N = ((IData)(vlSelfRef.rst_n) 
                                      && (((IData)(vlSelfRef.fdiv__DOT__is_inf) 
                                           & (~ (IData)(vlSelfRef.fdiv__DOT__is_nan))) 
                                          | VL_LTES_III(11, 0x00ffU, (IData)(vlSelfRef.fdiv__DOT__exp_N))));
    vlSelfRef.fdiv__DOT__st1_inf_S = ((IData)(vlSelfRef.rst_n) 
                                      && (((IData)(vlSelfRef.fdiv__DOT__is_inf) 
                                           & (~ (IData)(vlSelfRef.fdiv__DOT__is_nan))) 
                                          | VL_LTES_III(11, 0x00ffU, 
                                                        (0x000007ffU 
                                                         & ((IData)(vlSelfRef.fdiv__DOT__exp_N) 
                                                            - (IData)(1U))))));
    vlSelfRef.fdiv__DOT__st1_zero_C = ((IData)(vlSelfRef.rst_n) 
                                       && (((IData)(vlSelfRef.fdiv__DOT__is_zero) 
                                            & (~ (IData)(vlSelfRef.fdiv__DOT__is_nan))) 
                                           | VL_GTES_III(11, 0U, 
                                                         (0x000007ffU 
                                                          & ((IData)(1U) 
                                                             + (IData)(vlSelfRef.fdiv__DOT__exp_N))))));
    vlSelfRef.fdiv__DOT__st1_zero_N = ((IData)(vlSelfRef.rst_n) 
                                       && (((IData)(vlSelfRef.fdiv__DOT__is_zero) 
                                            & (~ (IData)(vlSelfRef.fdiv__DOT__is_nan))) 
                                           | VL_GTES_III(11, 0U, (IData)(vlSelfRef.fdiv__DOT__exp_N))));
    vlSelfRef.fdiv__DOT__st1_zero_S = ((IData)(vlSelfRef.rst_n) 
                                       && (((IData)(vlSelfRef.fdiv__DOT__is_zero) 
                                            & (~ (IData)(vlSelfRef.fdiv__DOT__is_nan))) 
                                           | VL_GTES_III(11, 0U, 
                                                         (0x000007ffU 
                                                          & ((IData)(vlSelfRef.fdiv__DOT__exp_N) 
                                                             - (IData)(1U))))));
}

void Vfdiv___024root___nba_sequent__TOP__1(Vfdiv___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfdiv___024root___nba_sequent__TOP__1\n"); );
    Vfdiv__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.fdiv__DOT__st1_y0_dy = vlSelfRef.fdiv__DOT__lut
        [(0x00000fffU & (vlSelfRef.fdiv__DOT__m_b >> 0x0bU))];
}

void Vfdiv___024root___eval_nba(Vfdiv___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfdiv___024root___eval_nba\n"); );
    Vfdiv__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((3ULL & vlSelfRef.__VnbaTriggered[0U])) {
        Vfdiv___024root___nba_sequent__TOP__0(vlSelf);
    }
    if ((1ULL & vlSelfRef.__VnbaTriggered[0U])) {
        Vfdiv___024root___nba_sequent__TOP__1(vlSelf);
    }
}

void Vfdiv___024root___trigger_orInto__act(VlUnpacked<QData/*63:0*/, 1> &out, const VlUnpacked<QData/*63:0*/, 1> &in) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfdiv___024root___trigger_orInto__act\n"); );
    // Locals
    IData/*31:0*/ n;
    // Body
    n = 0U;
    do {
        out[n] = (out[n] | in[n]);
        n = ((IData)(1U) + n);
    } while ((1U > n));
}

bool Vfdiv___024root___eval_phase__act(Vfdiv___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfdiv___024root___eval_phase__act\n"); );
    Vfdiv__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    Vfdiv___024root___eval_triggers__act(vlSelf);
    Vfdiv___024root___trigger_orInto__act(vlSelfRef.__VnbaTriggered, vlSelfRef.__VactTriggered);
    return (0U);
}

void Vfdiv___024root___trigger_clear__act(VlUnpacked<QData/*63:0*/, 1> &out) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfdiv___024root___trigger_clear__act\n"); );
    // Locals
    IData/*31:0*/ n;
    // Body
    n = 0U;
    do {
        out[n] = 0ULL;
        n = ((IData)(1U) + n);
    } while ((1U > n));
}

bool Vfdiv___024root___eval_phase__nba(Vfdiv___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfdiv___024root___eval_phase__nba\n"); );
    Vfdiv__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    CData/*0:0*/ __VnbaExecute;
    // Body
    __VnbaExecute = Vfdiv___024root___trigger_anySet__act(vlSelfRef.__VnbaTriggered);
    if (__VnbaExecute) {
        Vfdiv___024root___eval_nba(vlSelf);
        Vfdiv___024root___trigger_clear__act(vlSelfRef.__VnbaTriggered);
    }
    return (__VnbaExecute);
}

void Vfdiv___024root___eval(Vfdiv___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfdiv___024root___eval\n"); );
    Vfdiv__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    IData/*31:0*/ __VicoIterCount;
    IData/*31:0*/ __VnbaIterCount;
    // Body
    __VicoIterCount = 0U;
    vlSelfRef.__VicoFirstIteration = 1U;
    do {
        if (VL_UNLIKELY(((0x00000064U < __VicoIterCount)))) {
#ifdef VL_DEBUG
            Vfdiv___024root___dump_triggers__ico(vlSelfRef.__VicoTriggered, "ico"s);
#endif
            VL_FATAL_MT("sv/fdiv.sv", 3, "", "Input combinational region did not converge after 100 tries");
        }
        __VicoIterCount = ((IData)(1U) + __VicoIterCount);
    } while (Vfdiv___024root___eval_phase__ico(vlSelf));
    __VnbaIterCount = 0U;
    do {
        if (VL_UNLIKELY(((0x00000064U < __VnbaIterCount)))) {
#ifdef VL_DEBUG
            Vfdiv___024root___dump_triggers__act(vlSelfRef.__VnbaTriggered, "nba"s);
#endif
            VL_FATAL_MT("sv/fdiv.sv", 3, "", "NBA region did not converge after 100 tries");
        }
        __VnbaIterCount = ((IData)(1U) + __VnbaIterCount);
        vlSelfRef.__VactIterCount = 0U;
        do {
            if (VL_UNLIKELY(((0x00000064U < vlSelfRef.__VactIterCount)))) {
#ifdef VL_DEBUG
                Vfdiv___024root___dump_triggers__act(vlSelfRef.__VactTriggered, "act"s);
#endif
                VL_FATAL_MT("sv/fdiv.sv", 3, "", "Active region did not converge after 100 tries");
            }
            vlSelfRef.__VactIterCount = ((IData)(1U) 
                                         + vlSelfRef.__VactIterCount);
        } while (Vfdiv___024root___eval_phase__act(vlSelf));
    } while (Vfdiv___024root___eval_phase__nba(vlSelf));
}

#ifdef VL_DEBUG
void Vfdiv___024root___eval_debug_assertions(Vfdiv___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfdiv___024root___eval_debug_assertions\n"); );
    Vfdiv__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
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
