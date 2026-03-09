// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vfadd.h for the primary calling header

#include "Vfadd__pch.h"

#ifdef VL_DEBUG
VL_ATTR_COLD void Vfadd___024root___dump_triggers__ico(const VlUnpacked<QData/*63:0*/, 1> &triggers, const std::string &tag);
#endif  // VL_DEBUG

void Vfadd___024root___eval_triggers__ico(Vfadd___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfadd___024root___eval_triggers__ico\n"); );
    Vfadd__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.__VicoTriggered[0U] = ((0xfffffffffffffffeULL 
                                      & vlSelfRef.__VicoTriggered
                                      [0U]) | (IData)((IData)(vlSelfRef.__VicoFirstIteration)));
    vlSelfRef.__VicoFirstIteration = 0U;
#ifdef VL_DEBUG
    if (VL_UNLIKELY(vlSymsp->_vm_contextp__->debug())) {
        Vfadd___024root___dump_triggers__ico(vlSelfRef.__VicoTriggered, "ico"s);
    }
#endif
}

bool Vfadd___024root___trigger_anySet__ico(const VlUnpacked<QData/*63:0*/, 1> &in) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfadd___024root___trigger_anySet__ico\n"); );
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

void Vfadd___024root___ico_sequent__TOP__0(Vfadd___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfadd___024root___ico_sequent__TOP__0\n"); );
    Vfadd__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    CData/*7:0*/ fadd__DOT__c1_diff;
    fadd__DOT__c1_diff = 0;
    IData/*26:0*/ fadd__DOT__c1_mant_small;
    fadd__DOT__c1_mant_small = 0;
    // Body
    if (((0x7fffffffU & vlSelfRef.input_a) < (0x7fffffffU 
                                              & vlSelfRef.input_b))) {
        vlSelfRef.fadd__DOT__c1_large = vlSelfRef.input_b;
        vlSelfRef.fadd__DOT__c1_small = vlSelfRef.input_a;
    } else {
        vlSelfRef.fadd__DOT__c1_large = vlSelfRef.input_a;
        vlSelfRef.fadd__DOT__c1_small = vlSelfRef.input_b;
    }
    vlSelfRef.fadd__DOT__c1_mant_large = ((0U == (0x000000ffU 
                                                  & (vlSelfRef.fadd__DOT__c1_large 
                                                     >> 0x17U)))
                                           ? (0x03fffff8U 
                                              & (vlSelfRef.fadd__DOT__c1_large 
                                                 << 3U))
                                           : (0x04000000U 
                                              | (0x03fffff8U 
                                                 & (vlSelfRef.fadd__DOT__c1_large 
                                                    << 3U))));
    fadd__DOT__c1_mant_small = ((0U == (0x000000ffU 
                                        & (vlSelfRef.fadd__DOT__c1_small 
                                           >> 0x17U)))
                                 ? (0x03fffff8U & (vlSelfRef.fadd__DOT__c1_small 
                                                   << 3U))
                                 : (0x04000000U | (0x03fffff8U 
                                                   & (vlSelfRef.fadd__DOT__c1_small 
                                                      << 3U))));
    fadd__DOT__c1_diff = (0x000000ffU & ((vlSelfRef.fadd__DOT__c1_large 
                                          >> 0x17U) 
                                         - (vlSelfRef.fadd__DOT__c1_small 
                                            >> 0x17U)));
    if ((0x1bU <= (IData)(fadd__DOT__c1_diff))) {
        vlSelfRef.fadd__DOT__unnamedblk1__DOT__temp_shifted = 0U;
        vlSelfRef.fadd__DOT__c1_sticky = (0U != fadd__DOT__c1_mant_small);
    } else {
        vlSelfRef.fadd__DOT__unnamedblk1__DOT__temp_shifted 
            = (0x07ffffffU & VL_SHIFTR_III(27,27,8, fadd__DOT__c1_mant_small, (IData)(fadd__DOT__c1_diff)));
        vlSelfRef.fadd__DOT__c1_sticky = (0U != (fadd__DOT__c1_mant_small 
                                                 & (~ 
                                                    VL_SHIFTL_III(27,27,8, (IData)(0x07ffffffU), (IData)(fadd__DOT__c1_diff)))));
    }
    vlSelfRef.fadd__DOT__c1_mant_small_shifted = ((0x07fffffeU 
                                                   & vlSelfRef.fadd__DOT__unnamedblk1__DOT__temp_shifted) 
                                                  | (1U 
                                                     & (vlSelfRef.fadd__DOT__unnamedblk1__DOT__temp_shifted 
                                                        | (IData)(vlSelfRef.fadd__DOT__c1_sticky))));
    vlSelfRef.fadd__DOT__c1_effective_op = ((vlSelfRef.fadd__DOT__c1_large 
                                             ^ vlSelfRef.fadd__DOT__c1_small) 
                                            >> 0x1fU);
    vlSelfRef.fadd__DOT__c1_sign_res = (vlSelfRef.fadd__DOT__c1_large 
                                        >> 0x1fU);
    vlSelfRef.fadd__DOT__c1_exp_res = (0x000000ffU 
                                       & (vlSelfRef.fadd__DOT__c1_large 
                                          >> 0x17U));
}

void Vfadd___024root___eval_ico(Vfadd___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfadd___024root___eval_ico\n"); );
    Vfadd__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((1ULL & vlSelfRef.__VicoTriggered[0U])) {
        Vfadd___024root___ico_sequent__TOP__0(vlSelf);
    }
}

bool Vfadd___024root___eval_phase__ico(Vfadd___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfadd___024root___eval_phase__ico\n"); );
    Vfadd__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    CData/*0:0*/ __VicoExecute;
    // Body
    Vfadd___024root___eval_triggers__ico(vlSelf);
    __VicoExecute = Vfadd___024root___trigger_anySet__ico(vlSelfRef.__VicoTriggered);
    if (__VicoExecute) {
        Vfadd___024root___eval_ico(vlSelf);
    }
    return (__VicoExecute);
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vfadd___024root___dump_triggers__act(const VlUnpacked<QData/*63:0*/, 1> &triggers, const std::string &tag);
#endif  // VL_DEBUG

void Vfadd___024root___eval_triggers__act(Vfadd___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfadd___024root___eval_triggers__act\n"); );
    Vfadd__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.__VactTriggered[0U] = (QData)((IData)(
                                                    ((IData)(vlSelfRef.clk) 
                                                     & (~ (IData)(vlSelfRef.__Vtrigprevexpr___TOP__clk__0)))));
    vlSelfRef.__Vtrigprevexpr___TOP__clk__0 = vlSelfRef.clk;
#ifdef VL_DEBUG
    if (VL_UNLIKELY(vlSymsp->_vm_contextp__->debug())) {
        Vfadd___024root___dump_triggers__act(vlSelfRef.__VactTriggered, "act"s);
    }
#endif
}

bool Vfadd___024root___trigger_anySet__act(const VlUnpacked<QData/*63:0*/, 1> &in) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfadd___024root___trigger_anySet__act\n"); );
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

void Vfadd___024root___nba_sequent__TOP__0(Vfadd___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfadd___024root___nba_sequent__TOP__0\n"); );
    Vfadd__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    IData/*27:0*/ fadd__DOT__c2_mant_res;
    fadd__DOT__c2_mant_res = 0;
    CData/*4:0*/ fadd__DOT__c2_zlc;
    fadd__DOT__c2_zlc = 0;
    IData/*27:0*/ fadd__DOT__mant_final_shifted;
    fadd__DOT__mant_final_shifted = 0;
    CData/*0:0*/ fadd__DOT__round_up;
    fadd__DOT__round_up = 0;
    CData/*0:0*/ fadd__DOT__guard;
    fadd__DOT__guard = 0;
    CData/*0:0*/ fadd__DOT__round;
    fadd__DOT__round = 0;
    CData/*0:0*/ fadd__DOT__sticky;
    fadd__DOT__sticky = 0;
    CData/*0:0*/ fadd__DOT__lsb;
    fadd__DOT__lsb = 0;
    IData/*27:0*/ __Vfunc_fadd__DOT__count_leading_zeros__0__val;
    __Vfunc_fadd__DOT__count_leading_zeros__0__val = 0;
    IData/*31:0*/ __Vfunc_fadd__DOT__count_leading_zeros__0__i;
    __Vfunc_fadd__DOT__count_leading_zeros__0__i = 0;
    // Body
    if (vlSelfRef.rst_n) {
        vlSelfRef.result = vlSelfRef.fadd__DOT__c3_result_comb;
        vlSelfRef.fadd__DOT__s1_mant_large_reg = vlSelfRef.fadd__DOT__c1_mant_large;
        vlSelfRef.fadd__DOT__s1_mant_small_shifted_reg 
            = vlSelfRef.fadd__DOT__c1_mant_small_shifted;
        vlSelfRef.fadd__DOT__s1_exp_res_reg = vlSelfRef.fadd__DOT__c1_exp_res;
        vlSelfRef.fadd__DOT__s2_exp_reg = vlSelfRef.fadd__DOT__c2_exp_adjusted;
        vlSelfRef.fadd__DOT__s2_mant_reg = vlSelfRef.fadd__DOT__c2_mant_shifted_1;
        vlSelfRef.fadd__DOT__s2_shift_remain_reg = vlSelfRef.fadd__DOT__c2_shift_remain;
    } else {
        vlSelfRef.result = 0U;
        vlSelfRef.fadd__DOT__s1_mant_large_reg = 0U;
        vlSelfRef.fadd__DOT__s1_mant_small_shifted_reg = 0U;
        vlSelfRef.fadd__DOT__s1_exp_res_reg = 0U;
        vlSelfRef.fadd__DOT__s2_exp_reg = 0U;
        vlSelfRef.fadd__DOT__s2_mant_reg = 0U;
        vlSelfRef.fadd__DOT__s2_shift_remain_reg = 0U;
    }
    vlSelfRef.fadd__DOT__s1_effective_op_reg = ((IData)(vlSelfRef.rst_n) 
                                                && (IData)(vlSelfRef.fadd__DOT__c1_effective_op));
    vlSelfRef.out_valid = ((IData)(vlSelfRef.rst_n) 
                           && (IData)(vlSelfRef.fadd__DOT__s2_valid_reg));
    vlSelfRef.fadd__DOT__s2_sign_reg = ((IData)(vlSelfRef.rst_n) 
                                        && (IData)(vlSelfRef.fadd__DOT__s1_sign_res_reg));
    fadd__DOT__c2_mant_res = (0x0fffffffU & ((IData)(vlSelfRef.fadd__DOT__s1_effective_op_reg)
                                              ? (vlSelfRef.fadd__DOT__s1_mant_large_reg 
                                                 - vlSelfRef.fadd__DOT__s1_mant_small_shifted_reg)
                                              : (vlSelfRef.fadd__DOT__s1_mant_large_reg 
                                                 + vlSelfRef.fadd__DOT__s1_mant_small_shifted_reg)));
    __Vfunc_fadd__DOT__count_leading_zeros__0__val 
        = fadd__DOT__c2_mant_res;
    __Vfunc_fadd__DOT__count_leading_zeros__0__i = 0;
    {
        __Vfunc_fadd__DOT__count_leading_zeros__0__i = 0x0000001aU;
        if ((0x04000000U & __Vfunc_fadd__DOT__count_leading_zeros__0__val)) {
            vlSelfRef.__Vfunc_fadd__DOT__count_leading_zeros__0__Vfuncout = 0U;
            goto __Vlabel0;
        }
        __Vfunc_fadd__DOT__count_leading_zeros__0__i = 0x00000019U;
        if ((0x02000000U & __Vfunc_fadd__DOT__count_leading_zeros__0__val)) {
            vlSelfRef.__Vfunc_fadd__DOT__count_leading_zeros__0__Vfuncout = 1U;
            goto __Vlabel0;
        }
        __Vfunc_fadd__DOT__count_leading_zeros__0__i = 0x00000018U;
        if ((0x01000000U & __Vfunc_fadd__DOT__count_leading_zeros__0__val)) {
            vlSelfRef.__Vfunc_fadd__DOT__count_leading_zeros__0__Vfuncout = 2U;
            goto __Vlabel0;
        }
        __Vfunc_fadd__DOT__count_leading_zeros__0__i = 0x00000017U;
        if ((0x00800000U & __Vfunc_fadd__DOT__count_leading_zeros__0__val)) {
            vlSelfRef.__Vfunc_fadd__DOT__count_leading_zeros__0__Vfuncout = 3U;
            goto __Vlabel0;
        }
        __Vfunc_fadd__DOT__count_leading_zeros__0__i = 0x00000016U;
        if ((0x00400000U & __Vfunc_fadd__DOT__count_leading_zeros__0__val)) {
            vlSelfRef.__Vfunc_fadd__DOT__count_leading_zeros__0__Vfuncout = 4U;
            goto __Vlabel0;
        }
        __Vfunc_fadd__DOT__count_leading_zeros__0__i = 0x00000015U;
        if ((0x00200000U & __Vfunc_fadd__DOT__count_leading_zeros__0__val)) {
            vlSelfRef.__Vfunc_fadd__DOT__count_leading_zeros__0__Vfuncout = 5U;
            goto __Vlabel0;
        }
        __Vfunc_fadd__DOT__count_leading_zeros__0__i = 0x00000014U;
        if ((0x00100000U & __Vfunc_fadd__DOT__count_leading_zeros__0__val)) {
            vlSelfRef.__Vfunc_fadd__DOT__count_leading_zeros__0__Vfuncout = 6U;
            goto __Vlabel0;
        }
        __Vfunc_fadd__DOT__count_leading_zeros__0__i = 0x00000013U;
        if ((0x00080000U & __Vfunc_fadd__DOT__count_leading_zeros__0__val)) {
            vlSelfRef.__Vfunc_fadd__DOT__count_leading_zeros__0__Vfuncout = 7U;
            goto __Vlabel0;
        }
        __Vfunc_fadd__DOT__count_leading_zeros__0__i = 0x00000012U;
        if ((0x00040000U & __Vfunc_fadd__DOT__count_leading_zeros__0__val)) {
            vlSelfRef.__Vfunc_fadd__DOT__count_leading_zeros__0__Vfuncout = 8U;
            goto __Vlabel0;
        }
        __Vfunc_fadd__DOT__count_leading_zeros__0__i = 0x00000011U;
        if ((0x00020000U & __Vfunc_fadd__DOT__count_leading_zeros__0__val)) {
            vlSelfRef.__Vfunc_fadd__DOT__count_leading_zeros__0__Vfuncout = 9U;
            goto __Vlabel0;
        }
        __Vfunc_fadd__DOT__count_leading_zeros__0__i = 0x00000010U;
        if ((0x00010000U & __Vfunc_fadd__DOT__count_leading_zeros__0__val)) {
            vlSelfRef.__Vfunc_fadd__DOT__count_leading_zeros__0__Vfuncout = 0x0aU;
            goto __Vlabel0;
        }
        __Vfunc_fadd__DOT__count_leading_zeros__0__i = 0x0000000fU;
        if ((0x00008000U & __Vfunc_fadd__DOT__count_leading_zeros__0__val)) {
            vlSelfRef.__Vfunc_fadd__DOT__count_leading_zeros__0__Vfuncout = 0x0bU;
            goto __Vlabel0;
        }
        __Vfunc_fadd__DOT__count_leading_zeros__0__i = 0x0000000eU;
        if ((0x00004000U & __Vfunc_fadd__DOT__count_leading_zeros__0__val)) {
            vlSelfRef.__Vfunc_fadd__DOT__count_leading_zeros__0__Vfuncout = 0x0cU;
            goto __Vlabel0;
        }
        __Vfunc_fadd__DOT__count_leading_zeros__0__i = 0x0000000dU;
        if ((0x00002000U & __Vfunc_fadd__DOT__count_leading_zeros__0__val)) {
            vlSelfRef.__Vfunc_fadd__DOT__count_leading_zeros__0__Vfuncout = 0x0dU;
            goto __Vlabel0;
        }
        __Vfunc_fadd__DOT__count_leading_zeros__0__i = 0x0000000cU;
        if ((0x00001000U & __Vfunc_fadd__DOT__count_leading_zeros__0__val)) {
            vlSelfRef.__Vfunc_fadd__DOT__count_leading_zeros__0__Vfuncout = 0x0eU;
            goto __Vlabel0;
        }
        __Vfunc_fadd__DOT__count_leading_zeros__0__i = 0x0000000bU;
        if ((0x00000800U & __Vfunc_fadd__DOT__count_leading_zeros__0__val)) {
            vlSelfRef.__Vfunc_fadd__DOT__count_leading_zeros__0__Vfuncout = 0x0fU;
            goto __Vlabel0;
        }
        __Vfunc_fadd__DOT__count_leading_zeros__0__i = 0x0000000aU;
        if ((0x00000400U & __Vfunc_fadd__DOT__count_leading_zeros__0__val)) {
            vlSelfRef.__Vfunc_fadd__DOT__count_leading_zeros__0__Vfuncout = 0x10U;
            goto __Vlabel0;
        }
        __Vfunc_fadd__DOT__count_leading_zeros__0__i = 9U;
        if ((0x00000200U & __Vfunc_fadd__DOT__count_leading_zeros__0__val)) {
            vlSelfRef.__Vfunc_fadd__DOT__count_leading_zeros__0__Vfuncout = 0x11U;
            goto __Vlabel0;
        }
        __Vfunc_fadd__DOT__count_leading_zeros__0__i = 8U;
        if ((0x00000100U & __Vfunc_fadd__DOT__count_leading_zeros__0__val)) {
            vlSelfRef.__Vfunc_fadd__DOT__count_leading_zeros__0__Vfuncout = 0x12U;
            goto __Vlabel0;
        }
        __Vfunc_fadd__DOT__count_leading_zeros__0__i = 7U;
        if ((0x00000080U & __Vfunc_fadd__DOT__count_leading_zeros__0__val)) {
            vlSelfRef.__Vfunc_fadd__DOT__count_leading_zeros__0__Vfuncout = 0x13U;
            goto __Vlabel0;
        }
        __Vfunc_fadd__DOT__count_leading_zeros__0__i = 6U;
        if ((0x00000040U & __Vfunc_fadd__DOT__count_leading_zeros__0__val)) {
            vlSelfRef.__Vfunc_fadd__DOT__count_leading_zeros__0__Vfuncout = 0x14U;
            goto __Vlabel0;
        }
        __Vfunc_fadd__DOT__count_leading_zeros__0__i = 5U;
        if ((0x00000020U & __Vfunc_fadd__DOT__count_leading_zeros__0__val)) {
            vlSelfRef.__Vfunc_fadd__DOT__count_leading_zeros__0__Vfuncout = 0x15U;
            goto __Vlabel0;
        }
        __Vfunc_fadd__DOT__count_leading_zeros__0__i = 4U;
        if ((0x00000010U & __Vfunc_fadd__DOT__count_leading_zeros__0__val)) {
            vlSelfRef.__Vfunc_fadd__DOT__count_leading_zeros__0__Vfuncout = 0x16U;
            goto __Vlabel0;
        }
        __Vfunc_fadd__DOT__count_leading_zeros__0__i = 3U;
        if ((8U & __Vfunc_fadd__DOT__count_leading_zeros__0__val)) {
            vlSelfRef.__Vfunc_fadd__DOT__count_leading_zeros__0__Vfuncout = 0x17U;
            goto __Vlabel0;
        }
        __Vfunc_fadd__DOT__count_leading_zeros__0__i = 2U;
        if ((4U & __Vfunc_fadd__DOT__count_leading_zeros__0__val)) {
            vlSelfRef.__Vfunc_fadd__DOT__count_leading_zeros__0__Vfuncout = 0x18U;
            goto __Vlabel0;
        }
        __Vfunc_fadd__DOT__count_leading_zeros__0__i = 1U;
        if ((2U & __Vfunc_fadd__DOT__count_leading_zeros__0__val)) {
            vlSelfRef.__Vfunc_fadd__DOT__count_leading_zeros__0__Vfuncout = 0x19U;
            goto __Vlabel0;
        }
        __Vfunc_fadd__DOT__count_leading_zeros__0__i = 0U;
        if ((1U & __Vfunc_fadd__DOT__count_leading_zeros__0__val)) {
            vlSelfRef.__Vfunc_fadd__DOT__count_leading_zeros__0__Vfuncout = 0x1aU;
            goto __Vlabel0;
        }
        __Vfunc_fadd__DOT__count_leading_zeros__0__i = 0xffffffffU;
        vlSelfRef.__Vfunc_fadd__DOT__count_leading_zeros__0__Vfuncout = 0x1bU;
        __Vlabel0: ;
    }
    fadd__DOT__c2_zlc = vlSelfRef.__Vfunc_fadd__DOT__count_leading_zeros__0__Vfuncout;
    if ((0U == fadd__DOT__c2_mant_res)) {
        vlSelfRef.fadd__DOT__c2_exp_adjusted = 0U;
        vlSelfRef.fadd__DOT__c2_mant_shifted_1 = 0U;
        vlSelfRef.fadd__DOT__c2_shift_remain = 0U;
    } else if ((0x08000000U & fadd__DOT__c2_mant_res)) {
        vlSelfRef.fadd__DOT__c2_mant_shifted_1 = (0x0fffffffU 
                                                  & (VL_SHIFTR_III(28,28,32, fadd__DOT__c2_mant_res, 1U) 
                                                     | (1U 
                                                        & fadd__DOT__c2_mant_res)));
        vlSelfRef.fadd__DOT__c2_shift_remain = 0U;
        vlSelfRef.fadd__DOT__c2_exp_adjusted = (0x000000ffU 
                                                & ((IData)(1U) 
                                                   + (IData)(vlSelfRef.fadd__DOT__s1_exp_res_reg)));
    } else {
        vlSelfRef.fadd__DOT__c2_exp_adjusted = (((IData)(vlSelfRef.fadd__DOT__s1_exp_res_reg) 
                                                 < (IData)(fadd__DOT__c2_zlc))
                                                 ? 0U
                                                 : 
                                                (0x000000ffU 
                                                 & ((IData)(vlSelfRef.fadd__DOT__s1_exp_res_reg) 
                                                    - (IData)(fadd__DOT__c2_zlc))));
        vlSelfRef.fadd__DOT__c2_mant_shifted_1 = (0x0fffffffU 
                                                  & (fadd__DOT__c2_mant_res 
                                                     << 
                                                     (3U 
                                                      & (IData)(fadd__DOT__c2_zlc))));
        vlSelfRef.fadd__DOT__c2_shift_remain = (7U 
                                                & ((IData)(fadd__DOT__c2_zlc) 
                                                   >> 2U));
    }
    vlSelfRef.fadd__DOT__s2_valid_reg = ((IData)(vlSelfRef.rst_n) 
                                         && (IData)(vlSelfRef.fadd__DOT__s1_valid_reg));
    fadd__DOT__mant_final_shifted = (0x0fffffffU & 
                                     (vlSelfRef.fadd__DOT__s2_mant_reg 
                                      << ((IData)(vlSelfRef.fadd__DOT__s2_shift_remain_reg) 
                                          << 2U)));
    fadd__DOT__guard = (1U & (fadd__DOT__mant_final_shifted 
                              >> 2U));
    fadd__DOT__round = (1U & (fadd__DOT__mant_final_shifted 
                              >> 1U));
    fadd__DOT__sticky = (1U & fadd__DOT__mant_final_shifted);
    fadd__DOT__lsb = (1U & (fadd__DOT__mant_final_shifted 
                            >> 3U));
    fadd__DOT__round_up = ((IData)(fadd__DOT__guard) 
                           & (((IData)(fadd__DOT__round) 
                               | (IData)(fadd__DOT__sticky)) 
                              | (IData)(fadd__DOT__lsb)));
    if ((0U == (IData)(vlSelfRef.fadd__DOT__s2_exp_reg))) {
        vlSelfRef.fadd__DOT__frac_final = 0U;
        vlSelfRef.fadd__DOT__exp_final = 0U;
    } else if (fadd__DOT__round_up) {
        vlSelfRef.fadd__DOT__frac_rounded = (0x00ffffffU 
                                             & ((IData)(1U) 
                                                + (0x007fffffU 
                                                   & (fadd__DOT__mant_final_shifted 
                                                      >> 3U))));
        if ((0x00800000U & vlSelfRef.fadd__DOT__frac_rounded)) {
            vlSelfRef.fadd__DOT__frac_final = 0U;
            vlSelfRef.fadd__DOT__exp_final = (0x000000ffU 
                                              & ((IData)(1U) 
                                                 + (IData)(vlSelfRef.fadd__DOT__s2_exp_reg)));
        } else {
            vlSelfRef.fadd__DOT__frac_final = (0x007fffffU 
                                               & vlSelfRef.fadd__DOT__frac_rounded);
            vlSelfRef.fadd__DOT__exp_final = vlSelfRef.fadd__DOT__s2_exp_reg;
        }
    } else {
        vlSelfRef.fadd__DOT__frac_final = (0x007fffffU 
                                           & (fadd__DOT__mant_final_shifted 
                                              >> 3U));
        vlSelfRef.fadd__DOT__exp_final = vlSelfRef.fadd__DOT__s2_exp_reg;
    }
    vlSelfRef.fadd__DOT__c3_result_comb = (((IData)(vlSelfRef.fadd__DOT__s2_sign_reg) 
                                            << 0x0000001fU) 
                                           | (((IData)(vlSelfRef.fadd__DOT__exp_final) 
                                               << 0x00000017U) 
                                              | vlSelfRef.fadd__DOT__frac_final));
    vlSelfRef.fadd__DOT__s1_sign_res_reg = ((IData)(vlSelfRef.rst_n) 
                                            && (IData)(vlSelfRef.fadd__DOT__c1_sign_res));
    vlSelfRef.fadd__DOT__s1_valid_reg = ((IData)(vlSelfRef.rst_n) 
                                         && (IData)(vlSelfRef.input_valid));
}

void Vfadd___024root___eval_nba(Vfadd___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfadd___024root___eval_nba\n"); );
    Vfadd__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((1ULL & vlSelfRef.__VnbaTriggered[0U])) {
        Vfadd___024root___nba_sequent__TOP__0(vlSelf);
    }
}

void Vfadd___024root___trigger_orInto__act(VlUnpacked<QData/*63:0*/, 1> &out, const VlUnpacked<QData/*63:0*/, 1> &in) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfadd___024root___trigger_orInto__act\n"); );
    // Locals
    IData/*31:0*/ n;
    // Body
    n = 0U;
    do {
        out[n] = (out[n] | in[n]);
        n = ((IData)(1U) + n);
    } while ((1U > n));
}

bool Vfadd___024root___eval_phase__act(Vfadd___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfadd___024root___eval_phase__act\n"); );
    Vfadd__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    Vfadd___024root___eval_triggers__act(vlSelf);
    Vfadd___024root___trigger_orInto__act(vlSelfRef.__VnbaTriggered, vlSelfRef.__VactTriggered);
    return (0U);
}

void Vfadd___024root___trigger_clear__act(VlUnpacked<QData/*63:0*/, 1> &out) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfadd___024root___trigger_clear__act\n"); );
    // Locals
    IData/*31:0*/ n;
    // Body
    n = 0U;
    do {
        out[n] = 0ULL;
        n = ((IData)(1U) + n);
    } while ((1U > n));
}

bool Vfadd___024root___eval_phase__nba(Vfadd___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfadd___024root___eval_phase__nba\n"); );
    Vfadd__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    CData/*0:0*/ __VnbaExecute;
    // Body
    __VnbaExecute = Vfadd___024root___trigger_anySet__act(vlSelfRef.__VnbaTriggered);
    if (__VnbaExecute) {
        Vfadd___024root___eval_nba(vlSelf);
        Vfadd___024root___trigger_clear__act(vlSelfRef.__VnbaTriggered);
    }
    return (__VnbaExecute);
}

void Vfadd___024root___eval(Vfadd___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfadd___024root___eval\n"); );
    Vfadd__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
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
            Vfadd___024root___dump_triggers__ico(vlSelfRef.__VicoTriggered, "ico"s);
#endif
            VL_FATAL_MT("sv/fadd.sv", 3, "", "Input combinational region did not converge after 100 tries");
        }
        __VicoIterCount = ((IData)(1U) + __VicoIterCount);
    } while (Vfadd___024root___eval_phase__ico(vlSelf));
    __VnbaIterCount = 0U;
    do {
        if (VL_UNLIKELY(((0x00000064U < __VnbaIterCount)))) {
#ifdef VL_DEBUG
            Vfadd___024root___dump_triggers__act(vlSelfRef.__VnbaTriggered, "nba"s);
#endif
            VL_FATAL_MT("sv/fadd.sv", 3, "", "NBA region did not converge after 100 tries");
        }
        __VnbaIterCount = ((IData)(1U) + __VnbaIterCount);
        vlSelfRef.__VactIterCount = 0U;
        do {
            if (VL_UNLIKELY(((0x00000064U < vlSelfRef.__VactIterCount)))) {
#ifdef VL_DEBUG
                Vfadd___024root___dump_triggers__act(vlSelfRef.__VactTriggered, "act"s);
#endif
                VL_FATAL_MT("sv/fadd.sv", 3, "", "Active region did not converge after 100 tries");
            }
            vlSelfRef.__VactIterCount = ((IData)(1U) 
                                         + vlSelfRef.__VactIterCount);
        } while (Vfadd___024root___eval_phase__act(vlSelf));
    } while (Vfadd___024root___eval_phase__nba(vlSelf));
}

#ifdef VL_DEBUG
void Vfadd___024root___eval_debug_assertions(Vfadd___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfadd___024root___eval_debug_assertions\n"); );
    Vfadd__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
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
