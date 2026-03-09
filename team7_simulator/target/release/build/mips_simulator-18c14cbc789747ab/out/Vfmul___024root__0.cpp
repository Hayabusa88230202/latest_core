// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vfmul.h for the primary calling header

#include "Vfmul__pch.h"

#ifdef VL_DEBUG
VL_ATTR_COLD void Vfmul___024root___dump_triggers__ico(const VlUnpacked<QData/*63:0*/, 1> &triggers, const std::string &tag);
#endif  // VL_DEBUG

void Vfmul___024root___eval_triggers__ico(Vfmul___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfmul___024root___eval_triggers__ico\n"); );
    Vfmul__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.__VicoTriggered[0U] = ((0xfffffffffffffffeULL 
                                      & vlSelfRef.__VicoTriggered
                                      [0U]) | (IData)((IData)(vlSelfRef.__VicoFirstIteration)));
    vlSelfRef.__VicoFirstIteration = 0U;
#ifdef VL_DEBUG
    if (VL_UNLIKELY(vlSymsp->_vm_contextp__->debug())) {
        Vfmul___024root___dump_triggers__ico(vlSelfRef.__VicoTriggered, "ico"s);
    }
#endif
}

bool Vfmul___024root___trigger_anySet__ico(const VlUnpacked<QData/*63:0*/, 1> &in) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfmul___024root___trigger_anySet__ico\n"); );
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

void Vfmul___024root___ico_sequent__TOP__0(Vfmul___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfmul___024root___ico_sequent__TOP__0\n"); );
    Vfmul__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    CData/*0:0*/ fmul__DOT__s1_sign_a;
    fmul__DOT__s1_sign_a = 0;
    CData/*0:0*/ fmul__DOT__s1_sign_b;
    fmul__DOT__s1_sign_b = 0;
    CData/*7:0*/ fmul__DOT__s1_exp_a;
    fmul__DOT__s1_exp_a = 0;
    CData/*7:0*/ fmul__DOT__s1_exp_b;
    fmul__DOT__s1_exp_b = 0;
    IData/*23:0*/ fmul__DOT__s1_mant_a;
    fmul__DOT__s1_mant_a = 0;
    IData/*23:0*/ fmul__DOT__s1_mant_b;
    fmul__DOT__s1_mant_b = 0;
    // Body
    fmul__DOT__s1_sign_a = (vlSelfRef.input_a >> 0x1fU);
    fmul__DOT__s1_sign_b = (vlSelfRef.input_b >> 0x1fU);
    vlSelfRef.fmul__DOT__c1_sign_res = ((IData)(fmul__DOT__s1_sign_a) 
                                        ^ (IData)(fmul__DOT__s1_sign_b));
    fmul__DOT__s1_exp_a = (0x000000ffU & (vlSelfRef.input_a 
                                          >> 0x17U));
    fmul__DOT__s1_exp_b = (0x000000ffU & (vlSelfRef.input_b 
                                          >> 0x17U));
    fmul__DOT__s1_mant_a = ((0U == (IData)(fmul__DOT__s1_exp_a))
                             ? (0x007fffffU & vlSelfRef.input_a)
                             : (0x00800000U | (0x007fffffU 
                                               & vlSelfRef.input_a)));
    fmul__DOT__s1_mant_b = ((0U == (IData)(fmul__DOT__s1_exp_b))
                             ? (0x007fffffU & vlSelfRef.input_b)
                             : (0x00800000U | (0x007fffffU 
                                               & vlSelfRef.input_b)));
    vlSelfRef.fmul__DOT__c1_is_zero_or_sub = ((0U == (IData)(fmul__DOT__s1_exp_a)) 
                                              | (0U 
                                                 == (IData)(fmul__DOT__s1_exp_b)));
    vlSelfRef.fmul__DOT__c1_exp_temp = (0x000003ffU 
                                        & (((IData)(fmul__DOT__s1_exp_a) 
                                            + (IData)(fmul__DOT__s1_exp_b)) 
                                           - (IData)(0x007fU)));
    vlSelfRef.fmul__DOT__c1_mant_prod = (0x0000ffffffffffffULL 
                                         & ((QData)((IData)(fmul__DOT__s1_mant_a)) 
                                            * (QData)((IData)(fmul__DOT__s1_mant_b))));
}

void Vfmul___024root___eval_ico(Vfmul___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfmul___024root___eval_ico\n"); );
    Vfmul__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((1ULL & vlSelfRef.__VicoTriggered[0U])) {
        Vfmul___024root___ico_sequent__TOP__0(vlSelf);
    }
}

bool Vfmul___024root___eval_phase__ico(Vfmul___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfmul___024root___eval_phase__ico\n"); );
    Vfmul__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    CData/*0:0*/ __VicoExecute;
    // Body
    Vfmul___024root___eval_triggers__ico(vlSelf);
    __VicoExecute = Vfmul___024root___trigger_anySet__ico(vlSelfRef.__VicoTriggered);
    if (__VicoExecute) {
        Vfmul___024root___eval_ico(vlSelf);
    }
    return (__VicoExecute);
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vfmul___024root___dump_triggers__act(const VlUnpacked<QData/*63:0*/, 1> &triggers, const std::string &tag);
#endif  // VL_DEBUG

void Vfmul___024root___eval_triggers__act(Vfmul___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfmul___024root___eval_triggers__act\n"); );
    Vfmul__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.__VactTriggered[0U] = (QData)((IData)(
                                                    ((IData)(vlSelfRef.clk) 
                                                     & (~ (IData)(vlSelfRef.__Vtrigprevexpr___TOP__clk__0)))));
    vlSelfRef.__Vtrigprevexpr___TOP__clk__0 = vlSelfRef.clk;
#ifdef VL_DEBUG
    if (VL_UNLIKELY(vlSymsp->_vm_contextp__->debug())) {
        Vfmul___024root___dump_triggers__act(vlSelfRef.__VactTriggered, "act"s);
    }
#endif
}

bool Vfmul___024root___trigger_anySet__act(const VlUnpacked<QData/*63:0*/, 1> &in) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfmul___024root___trigger_anySet__act\n"); );
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

void Vfmul___024root___nba_sequent__TOP__0(Vfmul___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfmul___024root___nba_sequent__TOP__0\n"); );
    Vfmul__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    CData/*0:0*/ fmul__DOT__unnamedblk1__DOT__guard;
    fmul__DOT__unnamedblk1__DOT__guard = 0;
    CData/*0:0*/ fmul__DOT__unnamedblk1__DOT__round;
    fmul__DOT__unnamedblk1__DOT__round = 0;
    CData/*0:0*/ fmul__DOT__unnamedblk1__DOT__sticky;
    fmul__DOT__unnamedblk1__DOT__sticky = 0;
    CData/*0:0*/ fmul__DOT__unnamedblk1__DOT__lsb;
    fmul__DOT__unnamedblk1__DOT__lsb = 0;
    CData/*0:0*/ fmul__DOT__unnamedblk1__DOT__round_up;
    fmul__DOT__unnamedblk1__DOT__round_up = 0;
    // Body
    vlSelfRef.out_valid = ((IData)(vlSelfRef.rst_n) 
                           && (IData)(vlSelfRef.fmul__DOT__s2_valid_reg));
    vlSelfRef.fmul__DOT__s2_sign_reg = ((IData)(vlSelfRef.rst_n) 
                                        && (IData)(vlSelfRef.fmul__DOT__s1_sign_reg));
    vlSelfRef.fmul__DOT__s2_zero_reg = ((IData)(vlSelfRef.rst_n) 
                                        && (IData)(vlSelfRef.fmul__DOT__s1_zero_reg));
    vlSelfRef.fmul__DOT__s2_sticky_reg = ((IData)(vlSelfRef.rst_n) 
                                          && ((1U & (IData)(
                                                            (vlSelfRef.fmul__DOT__s1_prod_reg 
                                                             >> 0x0000002fU)))
                                               ? (0U 
                                                  != 
                                                  (0x000fffffU 
                                                   & (IData)(vlSelfRef.fmul__DOT__s1_prod_reg)))
                                               : (0U 
                                                  != 
                                                  (0x0007ffffU 
                                                   & (IData)(vlSelfRef.fmul__DOT__s1_prod_reg)))));
    if (vlSelfRef.rst_n) {
        vlSelfRef.result = vlSelfRef.fmul__DOT__c3_result_comb;
        vlSelfRef.fmul__DOT__s2_mant_reg = (0x07ffffffU 
                                            & ((1U 
                                                & (IData)(
                                                          (vlSelfRef.fmul__DOT__s1_prod_reg 
                                                           >> 0x0000002fU)))
                                                ? (IData)(
                                                          (vlSelfRef.fmul__DOT__s1_prod_reg 
                                                           >> 0x00000014U))
                                                : (IData)(
                                                          (vlSelfRef.fmul__DOT__s1_prod_reg 
                                                           >> 0x00000013U))));
        vlSelfRef.fmul__DOT__s2_exp_reg = (0x000003ffU 
                                           & ((IData)(vlSelfRef.fmul__DOT__s1_exp_reg) 
                                              + (1U 
                                                 & (IData)(
                                                           (vlSelfRef.fmul__DOT__s1_prod_reg 
                                                            >> 0x0000002fU)))));
        vlSelfRef.fmul__DOT__s1_exp_reg = vlSelfRef.fmul__DOT__c1_exp_temp;
        vlSelfRef.fmul__DOT__s1_prod_reg = vlSelfRef.fmul__DOT__c1_mant_prod;
    } else {
        vlSelfRef.result = 0U;
        vlSelfRef.fmul__DOT__s2_mant_reg = 0U;
        vlSelfRef.fmul__DOT__s2_exp_reg = 0U;
        vlSelfRef.fmul__DOT__s1_exp_reg = 0U;
        vlSelfRef.fmul__DOT__s1_prod_reg = 0ULL;
    }
    vlSelfRef.fmul__DOT__s2_valid_reg = ((IData)(vlSelfRef.rst_n) 
                                         && (IData)(vlSelfRef.fmul__DOT__s1_valid_reg));
    vlSelfRef.fmul__DOT__s1_sign_reg = ((IData)(vlSelfRef.rst_n) 
                                        && (IData)(vlSelfRef.fmul__DOT__c1_sign_res));
    vlSelfRef.fmul__DOT__s1_zero_reg = ((IData)(vlSelfRef.rst_n) 
                                        && (IData)(vlSelfRef.fmul__DOT__c1_is_zero_or_sub));
    fmul__DOT__unnamedblk1__DOT__guard = (1U & (vlSelfRef.fmul__DOT__s2_mant_reg 
                                                >> 3U));
    fmul__DOT__unnamedblk1__DOT__round = (1U & (vlSelfRef.fmul__DOT__s2_mant_reg 
                                                >> 2U));
    fmul__DOT__unnamedblk1__DOT__sticky = ((IData)(vlSelfRef.fmul__DOT__s2_sticky_reg) 
                                           | (0U != 
                                              (3U & vlSelfRef.fmul__DOT__s2_mant_reg)));
    fmul__DOT__unnamedblk1__DOT__lsb = (1U & (vlSelfRef.fmul__DOT__s2_mant_reg 
                                              >> 4U));
    fmul__DOT__unnamedblk1__DOT__round_up = ((IData)(fmul__DOT__unnamedblk1__DOT__guard) 
                                             & (((IData)(fmul__DOT__unnamedblk1__DOT__round) 
                                                 | (IData)(fmul__DOT__unnamedblk1__DOT__sticky)) 
                                                | (IData)(fmul__DOT__unnamedblk1__DOT__lsb)));
    if (fmul__DOT__unnamedblk1__DOT__round_up) {
        vlSelfRef.fmul__DOT__unnamedblk1__DOT__frac_final 
            = (0x007fffffU & ((IData)(1U) + (vlSelfRef.fmul__DOT__s2_mant_reg 
                                             >> 4U)));
        vlSelfRef.fmul__DOT__unnamedblk1__DOT__exp_checked 
            = (0x000003ffU & ((0U == vlSelfRef.fmul__DOT__unnamedblk1__DOT__frac_final)
                               ? ((IData)(1U) + (IData)(vlSelfRef.fmul__DOT__s2_exp_reg))
                               : (IData)(vlSelfRef.fmul__DOT__s2_exp_reg)));
    } else {
        vlSelfRef.fmul__DOT__unnamedblk1__DOT__frac_final 
            = (0x007fffffU & (vlSelfRef.fmul__DOT__s2_mant_reg 
                              >> 4U));
        vlSelfRef.fmul__DOT__unnamedblk1__DOT__exp_checked 
            = vlSelfRef.fmul__DOT__s2_exp_reg;
    }
    vlSelfRef.fmul__DOT__c3_result_comb = (((IData)(vlSelfRef.fmul__DOT__s2_zero_reg) 
                                            | ((IData)(vlSelfRef.fmul__DOT__unnamedblk1__DOT__exp_checked) 
                                               >> 9U))
                                            ? ((IData)(vlSelfRef.fmul__DOT__s2_sign_reg) 
                                               << 0x0000001fU)
                                            : ((0x00ffU 
                                                <= (IData)(vlSelfRef.fmul__DOT__unnamedblk1__DOT__exp_checked))
                                                ? (0x7f800000U 
                                                   | ((IData)(vlSelfRef.fmul__DOT__s2_sign_reg) 
                                                      << 0x0000001fU))
                                                : (
                                                   ((IData)(vlSelfRef.fmul__DOT__s2_sign_reg) 
                                                    << 0x0000001fU) 
                                                   | ((0x7f800000U 
                                                       & ((IData)(vlSelfRef.fmul__DOT__unnamedblk1__DOT__exp_checked) 
                                                          << 0x00000017U)) 
                                                      | vlSelfRef.fmul__DOT__unnamedblk1__DOT__frac_final))));
    vlSelfRef.fmul__DOT__s1_valid_reg = ((IData)(vlSelfRef.rst_n) 
                                         && (IData)(vlSelfRef.input_valid));
}

void Vfmul___024root___eval_nba(Vfmul___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfmul___024root___eval_nba\n"); );
    Vfmul__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((1ULL & vlSelfRef.__VnbaTriggered[0U])) {
        Vfmul___024root___nba_sequent__TOP__0(vlSelf);
    }
}

void Vfmul___024root___trigger_orInto__act(VlUnpacked<QData/*63:0*/, 1> &out, const VlUnpacked<QData/*63:0*/, 1> &in) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfmul___024root___trigger_orInto__act\n"); );
    // Locals
    IData/*31:0*/ n;
    // Body
    n = 0U;
    do {
        out[n] = (out[n] | in[n]);
        n = ((IData)(1U) + n);
    } while ((1U > n));
}

bool Vfmul___024root___eval_phase__act(Vfmul___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfmul___024root___eval_phase__act\n"); );
    Vfmul__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    Vfmul___024root___eval_triggers__act(vlSelf);
    Vfmul___024root___trigger_orInto__act(vlSelfRef.__VnbaTriggered, vlSelfRef.__VactTriggered);
    return (0U);
}

void Vfmul___024root___trigger_clear__act(VlUnpacked<QData/*63:0*/, 1> &out) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfmul___024root___trigger_clear__act\n"); );
    // Locals
    IData/*31:0*/ n;
    // Body
    n = 0U;
    do {
        out[n] = 0ULL;
        n = ((IData)(1U) + n);
    } while ((1U > n));
}

bool Vfmul___024root___eval_phase__nba(Vfmul___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfmul___024root___eval_phase__nba\n"); );
    Vfmul__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    CData/*0:0*/ __VnbaExecute;
    // Body
    __VnbaExecute = Vfmul___024root___trigger_anySet__act(vlSelfRef.__VnbaTriggered);
    if (__VnbaExecute) {
        Vfmul___024root___eval_nba(vlSelf);
        Vfmul___024root___trigger_clear__act(vlSelfRef.__VnbaTriggered);
    }
    return (__VnbaExecute);
}

void Vfmul___024root___eval(Vfmul___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfmul___024root___eval\n"); );
    Vfmul__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
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
            Vfmul___024root___dump_triggers__ico(vlSelfRef.__VicoTriggered, "ico"s);
#endif
            VL_FATAL_MT("sv/fmul.sv", 2, "", "Input combinational region did not converge after 100 tries");
        }
        __VicoIterCount = ((IData)(1U) + __VicoIterCount);
    } while (Vfmul___024root___eval_phase__ico(vlSelf));
    __VnbaIterCount = 0U;
    do {
        if (VL_UNLIKELY(((0x00000064U < __VnbaIterCount)))) {
#ifdef VL_DEBUG
            Vfmul___024root___dump_triggers__act(vlSelfRef.__VnbaTriggered, "nba"s);
#endif
            VL_FATAL_MT("sv/fmul.sv", 2, "", "NBA region did not converge after 100 tries");
        }
        __VnbaIterCount = ((IData)(1U) + __VnbaIterCount);
        vlSelfRef.__VactIterCount = 0U;
        do {
            if (VL_UNLIKELY(((0x00000064U < vlSelfRef.__VactIterCount)))) {
#ifdef VL_DEBUG
                Vfmul___024root___dump_triggers__act(vlSelfRef.__VactTriggered, "act"s);
#endif
                VL_FATAL_MT("sv/fmul.sv", 2, "", "Active region did not converge after 100 tries");
            }
            vlSelfRef.__VactIterCount = ((IData)(1U) 
                                         + vlSelfRef.__VactIterCount);
        } while (Vfmul___024root___eval_phase__act(vlSelf));
    } while (Vfmul___024root___eval_phase__nba(vlSelf));
}

#ifdef VL_DEBUG
void Vfmul___024root___eval_debug_assertions(Vfmul___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfmul___024root___eval_debug_assertions\n"); );
    Vfmul__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
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
