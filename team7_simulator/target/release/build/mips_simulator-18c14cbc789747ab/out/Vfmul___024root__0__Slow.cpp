// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vfmul.h for the primary calling header

#include "Vfmul__pch.h"

VL_ATTR_COLD void Vfmul___024root___eval_static(Vfmul___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfmul___024root___eval_static\n"); );
    Vfmul__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.__Vtrigprevexpr___TOP__clk__0 = vlSelfRef.clk;
}

VL_ATTR_COLD void Vfmul___024root___eval_initial(Vfmul___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfmul___024root___eval_initial\n"); );
    Vfmul__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
}

VL_ATTR_COLD void Vfmul___024root___eval_final(Vfmul___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfmul___024root___eval_final\n"); );
    Vfmul__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vfmul___024root___dump_triggers__stl(const VlUnpacked<QData/*63:0*/, 1> &triggers, const std::string &tag);
#endif  // VL_DEBUG
VL_ATTR_COLD bool Vfmul___024root___eval_phase__stl(Vfmul___024root* vlSelf);

VL_ATTR_COLD void Vfmul___024root___eval_settle(Vfmul___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfmul___024root___eval_settle\n"); );
    Vfmul__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    IData/*31:0*/ __VstlIterCount;
    // Body
    __VstlIterCount = 0U;
    vlSelfRef.__VstlFirstIteration = 1U;
    do {
        if (VL_UNLIKELY(((0x00000064U < __VstlIterCount)))) {
#ifdef VL_DEBUG
            Vfmul___024root___dump_triggers__stl(vlSelfRef.__VstlTriggered, "stl"s);
#endif
            VL_FATAL_MT("sv/fmul.sv", 2, "", "Settle region did not converge after 100 tries");
        }
        __VstlIterCount = ((IData)(1U) + __VstlIterCount);
    } while (Vfmul___024root___eval_phase__stl(vlSelf));
}

VL_ATTR_COLD void Vfmul___024root___eval_triggers__stl(Vfmul___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfmul___024root___eval_triggers__stl\n"); );
    Vfmul__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.__VstlTriggered[0U] = ((0xfffffffffffffffeULL 
                                      & vlSelfRef.__VstlTriggered
                                      [0U]) | (IData)((IData)(vlSelfRef.__VstlFirstIteration)));
    vlSelfRef.__VstlFirstIteration = 0U;
#ifdef VL_DEBUG
    if (VL_UNLIKELY(vlSymsp->_vm_contextp__->debug())) {
        Vfmul___024root___dump_triggers__stl(vlSelfRef.__VstlTriggered, "stl"s);
    }
#endif
}

VL_ATTR_COLD bool Vfmul___024root___trigger_anySet__stl(const VlUnpacked<QData/*63:0*/, 1> &in);

#ifdef VL_DEBUG
VL_ATTR_COLD void Vfmul___024root___dump_triggers__stl(const VlUnpacked<QData/*63:0*/, 1> &triggers, const std::string &tag) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfmul___024root___dump_triggers__stl\n"); );
    // Body
    if ((1U & (~ (IData)(Vfmul___024root___trigger_anySet__stl(triggers))))) {
        VL_DBG_MSGS("         No '" + tag + "' region triggers active\n");
    }
    if ((1U & (IData)(triggers[0U]))) {
        VL_DBG_MSGS("         '" + tag + "' region trigger index 0 is active: Internal 'stl' trigger - first iteration\n");
    }
}
#endif  // VL_DEBUG

VL_ATTR_COLD bool Vfmul___024root___trigger_anySet__stl(const VlUnpacked<QData/*63:0*/, 1> &in) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfmul___024root___trigger_anySet__stl\n"); );
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

VL_ATTR_COLD void Vfmul___024root___stl_sequent__TOP__0(Vfmul___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfmul___024root___stl_sequent__TOP__0\n"); );
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
}

VL_ATTR_COLD void Vfmul___024root___eval_stl(Vfmul___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfmul___024root___eval_stl\n"); );
    Vfmul__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((1ULL & vlSelfRef.__VstlTriggered[0U])) {
        Vfmul___024root___stl_sequent__TOP__0(vlSelf);
    }
}

VL_ATTR_COLD bool Vfmul___024root___eval_phase__stl(Vfmul___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfmul___024root___eval_phase__stl\n"); );
    Vfmul__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    CData/*0:0*/ __VstlExecute;
    // Body
    Vfmul___024root___eval_triggers__stl(vlSelf);
    __VstlExecute = Vfmul___024root___trigger_anySet__stl(vlSelfRef.__VstlTriggered);
    if (__VstlExecute) {
        Vfmul___024root___eval_stl(vlSelf);
    }
    return (__VstlExecute);
}

bool Vfmul___024root___trigger_anySet__ico(const VlUnpacked<QData/*63:0*/, 1> &in);

#ifdef VL_DEBUG
VL_ATTR_COLD void Vfmul___024root___dump_triggers__ico(const VlUnpacked<QData/*63:0*/, 1> &triggers, const std::string &tag) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfmul___024root___dump_triggers__ico\n"); );
    // Body
    if ((1U & (~ (IData)(Vfmul___024root___trigger_anySet__ico(triggers))))) {
        VL_DBG_MSGS("         No '" + tag + "' region triggers active\n");
    }
    if ((1U & (IData)(triggers[0U]))) {
        VL_DBG_MSGS("         '" + tag + "' region trigger index 0 is active: Internal 'ico' trigger - first iteration\n");
    }
}
#endif  // VL_DEBUG

bool Vfmul___024root___trigger_anySet__act(const VlUnpacked<QData/*63:0*/, 1> &in);

#ifdef VL_DEBUG
VL_ATTR_COLD void Vfmul___024root___dump_triggers__act(const VlUnpacked<QData/*63:0*/, 1> &triggers, const std::string &tag) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfmul___024root___dump_triggers__act\n"); );
    // Body
    if ((1U & (~ (IData)(Vfmul___024root___trigger_anySet__act(triggers))))) {
        VL_DBG_MSGS("         No '" + tag + "' region triggers active\n");
    }
    if ((1U & (IData)(triggers[0U]))) {
        VL_DBG_MSGS("         '" + tag + "' region trigger index 0 is active: @(posedge clk)\n");
    }
}
#endif  // VL_DEBUG

VL_ATTR_COLD void Vfmul___024root___ctor_var_reset(Vfmul___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfmul___024root___ctor_var_reset\n"); );
    Vfmul__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
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
    vlSelf->fmul__DOT__c1_sign_res = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 924213640456939334ull);
    vlSelf->fmul__DOT__c1_exp_temp = VL_SCOPED_RAND_RESET_I(10, __VscopeHash, 4722024179992182225ull);
    vlSelf->fmul__DOT__c1_mant_prod = VL_SCOPED_RAND_RESET_Q(48, __VscopeHash, 17503997385062493948ull);
    vlSelf->fmul__DOT__c1_is_zero_or_sub = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 7562049161405884813ull);
    vlSelf->fmul__DOT__s1_sign_reg = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 2376870754924827283ull);
    vlSelf->fmul__DOT__s1_exp_reg = VL_SCOPED_RAND_RESET_I(10, __VscopeHash, 11891485926335759278ull);
    vlSelf->fmul__DOT__s1_prod_reg = VL_SCOPED_RAND_RESET_Q(48, __VscopeHash, 10975760021509910099ull);
    vlSelf->fmul__DOT__s1_valid_reg = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 10145700060757770791ull);
    vlSelf->fmul__DOT__s1_zero_reg = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 15830221500523792237ull);
    vlSelf->fmul__DOT__s2_sign_reg = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 17229355550417089132ull);
    vlSelf->fmul__DOT__s2_exp_reg = VL_SCOPED_RAND_RESET_I(10, __VscopeHash, 8975178514219771821ull);
    vlSelf->fmul__DOT__s2_mant_reg = VL_SCOPED_RAND_RESET_I(27, __VscopeHash, 14511047775734246790ull);
    vlSelf->fmul__DOT__s2_sticky_reg = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 18291025046089284825ull);
    vlSelf->fmul__DOT__s2_valid_reg = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 14793249066422764522ull);
    vlSelf->fmul__DOT__s2_zero_reg = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 3266000060663731611ull);
    vlSelf->fmul__DOT__c3_result_comb = VL_SCOPED_RAND_RESET_I(32, __VscopeHash, 3435405400062841143ull);
    vlSelf->fmul__DOT__unnamedblk1__DOT__frac_final = VL_SCOPED_RAND_RESET_I(23, __VscopeHash, 3934614847675745807ull);
    vlSelf->fmul__DOT__unnamedblk1__DOT__exp_checked = VL_SCOPED_RAND_RESET_I(10, __VscopeHash, 282611399944028180ull);
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
