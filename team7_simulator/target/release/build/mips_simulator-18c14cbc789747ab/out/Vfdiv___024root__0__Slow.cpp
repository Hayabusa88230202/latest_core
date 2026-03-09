// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vfdiv.h for the primary calling header

#include "Vfdiv__pch.h"

VL_ATTR_COLD void Vfdiv___024root___eval_static(Vfdiv___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfdiv___024root___eval_static\n"); );
    Vfdiv__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.__Vtrigprevexpr___TOP__clk__0 = vlSelfRef.clk;
    vlSelfRef.__Vtrigprevexpr___TOP__rst_n__0 = vlSelfRef.rst_n;
}

VL_ATTR_COLD void Vfdiv___024root___eval_initial__TOP(Vfdiv___024root* vlSelf);

VL_ATTR_COLD void Vfdiv___024root___eval_initial(Vfdiv___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfdiv___024root___eval_initial\n"); );
    Vfdiv__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    Vfdiv___024root___eval_initial__TOP(vlSelf);
}

VL_ATTR_COLD void Vfdiv___024root___eval_initial__TOP(Vfdiv___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfdiv___024root___eval_initial__TOP\n"); );
    Vfdiv__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    VL_READMEM_N(true, 48, 4096, 0, "taylor_lut.hex"s
                 ,  &(vlSelfRef.fdiv__DOT__lut), 0, ~0ULL);
}

VL_ATTR_COLD void Vfdiv___024root___eval_final(Vfdiv___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfdiv___024root___eval_final\n"); );
    Vfdiv__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vfdiv___024root___dump_triggers__stl(const VlUnpacked<QData/*63:0*/, 1> &triggers, const std::string &tag);
#endif  // VL_DEBUG
VL_ATTR_COLD bool Vfdiv___024root___eval_phase__stl(Vfdiv___024root* vlSelf);

VL_ATTR_COLD void Vfdiv___024root___eval_settle(Vfdiv___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfdiv___024root___eval_settle\n"); );
    Vfdiv__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    IData/*31:0*/ __VstlIterCount;
    // Body
    __VstlIterCount = 0U;
    vlSelfRef.__VstlFirstIteration = 1U;
    do {
        if (VL_UNLIKELY(((0x00000064U < __VstlIterCount)))) {
#ifdef VL_DEBUG
            Vfdiv___024root___dump_triggers__stl(vlSelfRef.__VstlTriggered, "stl"s);
#endif
            VL_FATAL_MT("sv/fdiv.sv", 3, "", "Settle region did not converge after 100 tries");
        }
        __VstlIterCount = ((IData)(1U) + __VstlIterCount);
    } while (Vfdiv___024root___eval_phase__stl(vlSelf));
}

VL_ATTR_COLD void Vfdiv___024root___eval_triggers__stl(Vfdiv___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfdiv___024root___eval_triggers__stl\n"); );
    Vfdiv__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.__VstlTriggered[0U] = ((0xfffffffffffffffeULL 
                                      & vlSelfRef.__VstlTriggered
                                      [0U]) | (IData)((IData)(vlSelfRef.__VstlFirstIteration)));
    vlSelfRef.__VstlFirstIteration = 0U;
#ifdef VL_DEBUG
    if (VL_UNLIKELY(vlSymsp->_vm_contextp__->debug())) {
        Vfdiv___024root___dump_triggers__stl(vlSelfRef.__VstlTriggered, "stl"s);
    }
#endif
}

VL_ATTR_COLD bool Vfdiv___024root___trigger_anySet__stl(const VlUnpacked<QData/*63:0*/, 1> &in);

#ifdef VL_DEBUG
VL_ATTR_COLD void Vfdiv___024root___dump_triggers__stl(const VlUnpacked<QData/*63:0*/, 1> &triggers, const std::string &tag) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfdiv___024root___dump_triggers__stl\n"); );
    // Body
    if ((1U & (~ (IData)(Vfdiv___024root___trigger_anySet__stl(triggers))))) {
        VL_DBG_MSGS("         No '" + tag + "' region triggers active\n");
    }
    if ((1U & (IData)(triggers[0U]))) {
        VL_DBG_MSGS("         '" + tag + "' region trigger index 0 is active: Internal 'stl' trigger - first iteration\n");
    }
}
#endif  // VL_DEBUG

VL_ATTR_COLD bool Vfdiv___024root___trigger_anySet__stl(const VlUnpacked<QData/*63:0*/, 1> &in) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfdiv___024root___trigger_anySet__stl\n"); );
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

VL_ATTR_COLD void Vfdiv___024root___stl_sequent__TOP__0(Vfdiv___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfdiv___024root___stl_sequent__TOP__0\n"); );
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

VL_ATTR_COLD void Vfdiv___024root___eval_stl(Vfdiv___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfdiv___024root___eval_stl\n"); );
    Vfdiv__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((1ULL & vlSelfRef.__VstlTriggered[0U])) {
        Vfdiv___024root___stl_sequent__TOP__0(vlSelf);
    }
}

VL_ATTR_COLD bool Vfdiv___024root___eval_phase__stl(Vfdiv___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfdiv___024root___eval_phase__stl\n"); );
    Vfdiv__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    CData/*0:0*/ __VstlExecute;
    // Body
    Vfdiv___024root___eval_triggers__stl(vlSelf);
    __VstlExecute = Vfdiv___024root___trigger_anySet__stl(vlSelfRef.__VstlTriggered);
    if (__VstlExecute) {
        Vfdiv___024root___eval_stl(vlSelf);
    }
    return (__VstlExecute);
}

bool Vfdiv___024root___trigger_anySet__ico(const VlUnpacked<QData/*63:0*/, 1> &in);

#ifdef VL_DEBUG
VL_ATTR_COLD void Vfdiv___024root___dump_triggers__ico(const VlUnpacked<QData/*63:0*/, 1> &triggers, const std::string &tag) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfdiv___024root___dump_triggers__ico\n"); );
    // Body
    if ((1U & (~ (IData)(Vfdiv___024root___trigger_anySet__ico(triggers))))) {
        VL_DBG_MSGS("         No '" + tag + "' region triggers active\n");
    }
    if ((1U & (IData)(triggers[0U]))) {
        VL_DBG_MSGS("         '" + tag + "' region trigger index 0 is active: Internal 'ico' trigger - first iteration\n");
    }
}
#endif  // VL_DEBUG

bool Vfdiv___024root___trigger_anySet__act(const VlUnpacked<QData/*63:0*/, 1> &in);

#ifdef VL_DEBUG
VL_ATTR_COLD void Vfdiv___024root___dump_triggers__act(const VlUnpacked<QData/*63:0*/, 1> &triggers, const std::string &tag) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfdiv___024root___dump_triggers__act\n"); );
    // Body
    if ((1U & (~ (IData)(Vfdiv___024root___trigger_anySet__act(triggers))))) {
        VL_DBG_MSGS("         No '" + tag + "' region triggers active\n");
    }
    if ((1U & (IData)(triggers[0U]))) {
        VL_DBG_MSGS("         '" + tag + "' region trigger index 0 is active: @(posedge clk)\n");
    }
    if ((1U & (IData)((triggers[0U] >> 1U)))) {
        VL_DBG_MSGS("         '" + tag + "' region trigger index 1 is active: @(negedge rst_n)\n");
    }
}
#endif  // VL_DEBUG

VL_ATTR_COLD void Vfdiv___024root___ctor_var_reset(Vfdiv___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfdiv___024root___ctor_var_reset\n"); );
    Vfdiv__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    const uint64_t __VscopeHash = VL_MURMUR64_HASH(vlSelf->name());
    vlSelf->clk = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 16707436170211756652ull);
    vlSelf->rst_n = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 1638864771569018232ull);
    vlSelf->input_a = VL_SCOPED_RAND_RESET_I(32, __VscopeHash, 17200245311843468596ull);
    vlSelf->input_b = VL_SCOPED_RAND_RESET_I(32, __VscopeHash, 14333736170103073446ull);
    vlSelf->input_valid = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 4270309033785105452ull);
    vlSelf->result = VL_SCOPED_RAND_RESET_I(32, __VscopeHash, 16664408842984530663ull);
    vlSelf->out_valid = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 2886291494070200219ull);
    vlSelf->fdiv__DOT__m_a = VL_SCOPED_RAND_RESET_I(24, __VscopeHash, 10769448578542919113ull);
    vlSelf->fdiv__DOT__m_b = VL_SCOPED_RAND_RESET_I(24, __VscopeHash, 5051581410212329542ull);
    for (int __Vi0 = 0; __Vi0 < 4096; ++__Vi0) {
        vlSelf->fdiv__DOT__lut[__Vi0] = VL_SCOPED_RAND_RESET_Q(48, __VscopeHash, 10007966715957329350ull);
    }
    vlSelf->fdiv__DOT__st1_valid = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 18380340910409347209ull);
    vlSelf->fdiv__DOT__st1_sign = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 6153744738128079821ull);
    vlSelf->fdiv__DOT__st1_nan = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 10985724383742964743ull);
    vlSelf->fdiv__DOT__st1_adjusted_a = VL_SCOPED_RAND_RESET_I(25, __VscopeHash, 14619545394088365455ull);
    vlSelf->fdiv__DOT__st1_m_b_10_0 = VL_SCOPED_RAND_RESET_I(11, __VscopeHash, 4125061249729235175ull);
    vlSelf->fdiv__DOT__st1_y0_dy = VL_SCOPED_RAND_RESET_Q(48, __VscopeHash, 14645583870377148588ull);
    vlSelf->fdiv__DOT__st1_bias = VL_SCOPED_RAND_RESET_Q(49, __VscopeHash, 11717318910713977845ull);
    vlSelf->fdiv__DOT__st1_exp_C = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 8527682833830627731ull);
    vlSelf->fdiv__DOT__st1_exp_N = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 3733480090562141207ull);
    vlSelf->fdiv__DOT__st1_exp_S = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 5478254799109305945ull);
    vlSelf->fdiv__DOT__st1_inf_C = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 1889313644109406934ull);
    vlSelf->fdiv__DOT__st1_inf_N = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 6411531938792107815ull);
    vlSelf->fdiv__DOT__st1_inf_S = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 6151918721813037999ull);
    vlSelf->fdiv__DOT__st1_zero_C = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 9992992068261936138ull);
    vlSelf->fdiv__DOT__st1_zero_N = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 15838298209590323721ull);
    vlSelf->fdiv__DOT__st1_zero_S = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 2762238803862834524ull);
    vlSelf->fdiv__DOT__shift_pred = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 2762625030992809146ull);
    vlSelf->fdiv__DOT__exp_N = VL_SCOPED_RAND_RESET_I(11, __VscopeHash, 14431380729132773782ull);
    vlSelf->fdiv__DOT__is_nan = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 3191628727221646410ull);
    vlSelf->fdiv__DOT__is_inf = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 7997863993561791775ull);
    vlSelf->fdiv__DOT__is_zero = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 16841059225832229609ull);
    vlSelf->fdiv__DOT__st2_valid = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 4449557441684693414ull);
    vlSelf->fdiv__DOT__st2_sign = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 3666465130247660620ull);
    vlSelf->fdiv__DOT__st2_nan = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 1167786415891843492ull);
    vlSelf->fdiv__DOT__st2_adjusted_a = VL_SCOPED_RAND_RESET_I(25, __VscopeHash, 16140256332013275045ull);
    vlSelf->fdiv__DOT__st2_x1 = VL_SCOPED_RAND_RESET_I(24, __VscopeHash, 9679086713886035271ull);
    vlSelf->fdiv__DOT__st2_bias = VL_SCOPED_RAND_RESET_Q(49, __VscopeHash, 9315051806705694052ull);
    vlSelf->fdiv__DOT__st2_exp_C = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 2569200833054773513ull);
    vlSelf->fdiv__DOT__st2_exp_N = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 3236652815128611750ull);
    vlSelf->fdiv__DOT__st2_exp_S = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 10174248686896941577ull);
    vlSelf->fdiv__DOT__st2_inf_C = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 4013148250628358833ull);
    vlSelf->fdiv__DOT__st2_inf_N = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 10045495612150216494ull);
    vlSelf->fdiv__DOT__st2_inf_S = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 11109412880977099085ull);
    vlSelf->fdiv__DOT__st2_zero_C = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 13834661376868985506ull);
    vlSelf->fdiv__DOT__st2_zero_N = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 8521393434986048193ull);
    vlSelf->fdiv__DOT__st2_zero_S = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 16874496752265782435ull);
    vlSelf->fdiv__DOT__q_final = VL_SCOPED_RAND_RESET_Q(49, __VscopeHash, 11550873229146248805ull);
    for (int __Vi0 = 0; __Vi0 < 1; ++__Vi0) {
        vlSelf->__VstlTriggered[__Vi0] = 0;
    }
    for (int __Vi0 = 0; __Vi0 < 1; ++__Vi0) {
        vlSelf->__VicoTriggered[__Vi0] = 0;
    }
    for (int __Vi0 = 0; __Vi0 < 1; ++__Vi0) {
        vlSelf->__VactTriggered[__Vi0] = 0;
    }
    vlSelf->__Vtrigprevexpr___TOP__clk__0 = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 9526919608049418986ull);
    vlSelf->__Vtrigprevexpr___TOP__rst_n__0 = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 14803524876191471008ull);
    for (int __Vi0 = 0; __Vi0 < 1; ++__Vi0) {
        vlSelf->__VnbaTriggered[__Vi0] = 0;
    }
}
