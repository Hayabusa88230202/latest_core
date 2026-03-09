// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vfadd.h for the primary calling header

#include "Vfadd__pch.h"

VL_ATTR_COLD void Vfadd___024root___eval_static(Vfadd___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfadd___024root___eval_static\n"); );
    Vfadd__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.__Vtrigprevexpr___TOP__clk__0 = vlSelfRef.clk;
}

VL_ATTR_COLD void Vfadd___024root___eval_initial(Vfadd___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfadd___024root___eval_initial\n"); );
    Vfadd__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
}

VL_ATTR_COLD void Vfadd___024root___eval_final(Vfadd___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfadd___024root___eval_final\n"); );
    Vfadd__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vfadd___024root___dump_triggers__stl(const VlUnpacked<QData/*63:0*/, 1> &triggers, const std::string &tag);
#endif  // VL_DEBUG
VL_ATTR_COLD bool Vfadd___024root___eval_phase__stl(Vfadd___024root* vlSelf);

VL_ATTR_COLD void Vfadd___024root___eval_settle(Vfadd___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfadd___024root___eval_settle\n"); );
    Vfadd__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    IData/*31:0*/ __VstlIterCount;
    // Body
    __VstlIterCount = 0U;
    vlSelfRef.__VstlFirstIteration = 1U;
    do {
        if (VL_UNLIKELY(((0x00000064U < __VstlIterCount)))) {
#ifdef VL_DEBUG
            Vfadd___024root___dump_triggers__stl(vlSelfRef.__VstlTriggered, "stl"s);
#endif
            VL_FATAL_MT("sv/fadd.sv", 3, "", "Settle region did not converge after 100 tries");
        }
        __VstlIterCount = ((IData)(1U) + __VstlIterCount);
    } while (Vfadd___024root___eval_phase__stl(vlSelf));
}

VL_ATTR_COLD void Vfadd___024root___eval_triggers__stl(Vfadd___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfadd___024root___eval_triggers__stl\n"); );
    Vfadd__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.__VstlTriggered[0U] = ((0xfffffffffffffffeULL 
                                      & vlSelfRef.__VstlTriggered
                                      [0U]) | (IData)((IData)(vlSelfRef.__VstlFirstIteration)));
    vlSelfRef.__VstlFirstIteration = 0U;
#ifdef VL_DEBUG
    if (VL_UNLIKELY(vlSymsp->_vm_contextp__->debug())) {
        Vfadd___024root___dump_triggers__stl(vlSelfRef.__VstlTriggered, "stl"s);
    }
#endif
}

VL_ATTR_COLD bool Vfadd___024root___trigger_anySet__stl(const VlUnpacked<QData/*63:0*/, 1> &in);

#ifdef VL_DEBUG
VL_ATTR_COLD void Vfadd___024root___dump_triggers__stl(const VlUnpacked<QData/*63:0*/, 1> &triggers, const std::string &tag) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfadd___024root___dump_triggers__stl\n"); );
    // Body
    if ((1U & (~ (IData)(Vfadd___024root___trigger_anySet__stl(triggers))))) {
        VL_DBG_MSGS("         No '" + tag + "' region triggers active\n");
    }
    if ((1U & (IData)(triggers[0U]))) {
        VL_DBG_MSGS("         '" + tag + "' region trigger index 0 is active: Internal 'stl' trigger - first iteration\n");
    }
}
#endif  // VL_DEBUG

VL_ATTR_COLD bool Vfadd___024root___trigger_anySet__stl(const VlUnpacked<QData/*63:0*/, 1> &in) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfadd___024root___trigger_anySet__stl\n"); );
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

VL_ATTR_COLD void Vfadd___024root___stl_sequent__TOP__0(Vfadd___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfadd___024root___stl_sequent__TOP__0\n"); );
    Vfadd__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    CData/*7:0*/ fadd__DOT__c1_diff;
    fadd__DOT__c1_diff = 0;
    IData/*26:0*/ fadd__DOT__c1_mant_small;
    fadd__DOT__c1_mant_small = 0;
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
}

VL_ATTR_COLD void Vfadd___024root___eval_stl(Vfadd___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfadd___024root___eval_stl\n"); );
    Vfadd__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((1ULL & vlSelfRef.__VstlTriggered[0U])) {
        Vfadd___024root___stl_sequent__TOP__0(vlSelf);
    }
}

VL_ATTR_COLD bool Vfadd___024root___eval_phase__stl(Vfadd___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfadd___024root___eval_phase__stl\n"); );
    Vfadd__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    CData/*0:0*/ __VstlExecute;
    // Body
    Vfadd___024root___eval_triggers__stl(vlSelf);
    __VstlExecute = Vfadd___024root___trigger_anySet__stl(vlSelfRef.__VstlTriggered);
    if (__VstlExecute) {
        Vfadd___024root___eval_stl(vlSelf);
    }
    return (__VstlExecute);
}

bool Vfadd___024root___trigger_anySet__ico(const VlUnpacked<QData/*63:0*/, 1> &in);

#ifdef VL_DEBUG
VL_ATTR_COLD void Vfadd___024root___dump_triggers__ico(const VlUnpacked<QData/*63:0*/, 1> &triggers, const std::string &tag) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfadd___024root___dump_triggers__ico\n"); );
    // Body
    if ((1U & (~ (IData)(Vfadd___024root___trigger_anySet__ico(triggers))))) {
        VL_DBG_MSGS("         No '" + tag + "' region triggers active\n");
    }
    if ((1U & (IData)(triggers[0U]))) {
        VL_DBG_MSGS("         '" + tag + "' region trigger index 0 is active: Internal 'ico' trigger - first iteration\n");
    }
}
#endif  // VL_DEBUG

bool Vfadd___024root___trigger_anySet__act(const VlUnpacked<QData/*63:0*/, 1> &in);

#ifdef VL_DEBUG
VL_ATTR_COLD void Vfadd___024root___dump_triggers__act(const VlUnpacked<QData/*63:0*/, 1> &triggers, const std::string &tag) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfadd___024root___dump_triggers__act\n"); );
    // Body
    if ((1U & (~ (IData)(Vfadd___024root___trigger_anySet__act(triggers))))) {
        VL_DBG_MSGS("         No '" + tag + "' region triggers active\n");
    }
    if ((1U & (IData)(triggers[0U]))) {
        VL_DBG_MSGS("         '" + tag + "' region trigger index 0 is active: @(posedge clk)\n");
    }
}
#endif  // VL_DEBUG

VL_ATTR_COLD void Vfadd___024root___ctor_var_reset(Vfadd___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfadd___024root___ctor_var_reset\n"); );
    Vfadd__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
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
    vlSelf->fadd__DOT__c1_large = VL_SCOPED_RAND_RESET_I(32, __VscopeHash, 1713267488041770793ull);
    vlSelf->fadd__DOT__c1_small = VL_SCOPED_RAND_RESET_I(32, __VscopeHash, 9495696359608637993ull);
    vlSelf->fadd__DOT__c1_mant_large = VL_SCOPED_RAND_RESET_I(27, __VscopeHash, 7857758608155182636ull);
    vlSelf->fadd__DOT__c1_mant_small_shifted = VL_SCOPED_RAND_RESET_I(27, __VscopeHash, 15595027064366647611ull);
    vlSelf->fadd__DOT__c1_sticky = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 16485173547583530130ull);
    vlSelf->fadd__DOT__c1_effective_op = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 5590177660284281817ull);
    vlSelf->fadd__DOT__c1_sign_res = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 16645091079489899730ull);
    vlSelf->fadd__DOT__c1_exp_res = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 6458421233273450341ull);
    vlSelf->fadd__DOT__s1_mant_large_reg = VL_SCOPED_RAND_RESET_I(27, __VscopeHash, 7922722058246145423ull);
    vlSelf->fadd__DOT__s1_mant_small_shifted_reg = VL_SCOPED_RAND_RESET_I(27, __VscopeHash, 317548922898994018ull);
    vlSelf->fadd__DOT__s1_effective_op_reg = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 14743739707263046408ull);
    vlSelf->fadd__DOT__s1_sign_res_reg = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 10781200700140813495ull);
    vlSelf->fadd__DOT__s1_exp_res_reg = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 5666295260789388173ull);
    vlSelf->fadd__DOT__s1_valid_reg = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 7303983919813870980ull);
    vlSelf->fadd__DOT__c2_mant_shifted_1 = VL_SCOPED_RAND_RESET_I(28, __VscopeHash, 1268009806144926621ull);
    vlSelf->fadd__DOT__c2_exp_adjusted = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 2516882373641140497ull);
    vlSelf->fadd__DOT__c2_shift_remain = VL_SCOPED_RAND_RESET_I(3, __VscopeHash, 9408684776614494478ull);
    vlSelf->fadd__DOT__s2_mant_reg = VL_SCOPED_RAND_RESET_I(28, __VscopeHash, 7261851974802706102ull);
    vlSelf->fadd__DOT__s2_shift_remain_reg = VL_SCOPED_RAND_RESET_I(3, __VscopeHash, 15067547396807158802ull);
    vlSelf->fadd__DOT__s2_exp_reg = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 8637867592753849564ull);
    vlSelf->fadd__DOT__s2_sign_reg = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 7402676054741169872ull);
    vlSelf->fadd__DOT__s2_valid_reg = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 12712717735547815962ull);
    vlSelf->fadd__DOT__c3_result_comb = VL_SCOPED_RAND_RESET_I(32, __VscopeHash, 12168288445151789361ull);
    vlSelf->fadd__DOT__frac_final = VL_SCOPED_RAND_RESET_I(23, __VscopeHash, 15491819082889227984ull);
    vlSelf->fadd__DOT__exp_final = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 11759840927235732007ull);
    vlSelf->fadd__DOT__frac_rounded = VL_SCOPED_RAND_RESET_I(24, __VscopeHash, 10242171310814238859ull);
    vlSelf->fadd__DOT__unnamedblk1__DOT__temp_shifted = VL_SCOPED_RAND_RESET_I(27, __VscopeHash, 5149250361894243881ull);
    vlSelf->__Vfunc_fadd__DOT__count_leading_zeros__0__Vfuncout = VL_SCOPED_RAND_RESET_I(5, __VscopeHash, 12007617290542584940ull);
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
    for (int __Vi0 = 0; __Vi0 < 1; ++__Vi0) {
        vlSelf->__VnbaTriggered[__Vi0] = 0;
    }
}
