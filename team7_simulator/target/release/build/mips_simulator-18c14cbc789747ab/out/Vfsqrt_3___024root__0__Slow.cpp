// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vfsqrt_3.h for the primary calling header

#include "Vfsqrt_3__pch.h"

VL_ATTR_COLD void Vfsqrt_3___024root___eval_static(Vfsqrt_3___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfsqrt_3___024root___eval_static\n"); );
    Vfsqrt_3__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.__Vtrigprevexpr___TOP__clk__0 = vlSelfRef.clk;
    vlSelfRef.__Vtrigprevexpr___TOP__rst_n__0 = vlSelfRef.rst_n;
}

VL_ATTR_COLD void Vfsqrt_3___024root___eval_initial__TOP(Vfsqrt_3___024root* vlSelf);

VL_ATTR_COLD void Vfsqrt_3___024root___eval_initial(Vfsqrt_3___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfsqrt_3___024root___eval_initial\n"); );
    Vfsqrt_3__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    Vfsqrt_3___024root___eval_initial__TOP(vlSelf);
}

VL_ATTR_COLD void Vfsqrt_3___024root___eval_initial__TOP(Vfsqrt_3___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfsqrt_3___024root___eval_initial__TOP\n"); );
    Vfsqrt_3__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    IData/*31:0*/ fsqrt__DOT__unnamedblk1__DOT__i;
    fsqrt__DOT__unnamedblk1__DOT__i = 0;
    // Body
    VL_READMEM_N(true, 24, 1024, 0, "fsqrt_table.hex"s
                 ,  &(vlSelfRef.fsqrt__DOT__lut), 0
                 , ~0ULL);
    fsqrt__DOT__unnamedblk1__DOT__i = 0U;
    while (VL_GTS_III(32, 0x00000400U, fsqrt__DOT__unnamedblk1__DOT__i)) {
        vlSelfRef.fsqrt__DOT__lut_sq[(0x000003ffU & fsqrt__DOT__unnamedblk1__DOT__i)] 
            = (0x00ffffffU & (IData)((0x0000000000ffffffULL 
                                      & (((QData)((IData)(
                                                          vlSelfRef.fsqrt__DOT__lut
                                                          [
                                                          (0x000003ffU 
                                                           & fsqrt__DOT__unnamedblk1__DOT__i)])) 
                                          * (QData)((IData)(
                                                            vlSelfRef.fsqrt__DOT__lut
                                                            [
                                                            (0x000003ffU 
                                                             & fsqrt__DOT__unnamedblk1__DOT__i)]))) 
                                         >> 0x00000018U))));
        fsqrt__DOT__unnamedblk1__DOT__i = ((IData)(1U) 
                                           + fsqrt__DOT__unnamedblk1__DOT__i);
    }
}

VL_ATTR_COLD void Vfsqrt_3___024root___eval_final(Vfsqrt_3___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfsqrt_3___024root___eval_final\n"); );
    Vfsqrt_3__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vfsqrt_3___024root___dump_triggers__stl(const VlUnpacked<QData/*63:0*/, 1> &triggers, const std::string &tag);
#endif  // VL_DEBUG
VL_ATTR_COLD bool Vfsqrt_3___024root___eval_phase__stl(Vfsqrt_3___024root* vlSelf);

VL_ATTR_COLD void Vfsqrt_3___024root___eval_settle(Vfsqrt_3___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfsqrt_3___024root___eval_settle\n"); );
    Vfsqrt_3__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    IData/*31:0*/ __VstlIterCount;
    // Body
    __VstlIterCount = 0U;
    vlSelfRef.__VstlFirstIteration = 1U;
    do {
        if (VL_UNLIKELY(((0x00000064U < __VstlIterCount)))) {
#ifdef VL_DEBUG
            Vfsqrt_3___024root___dump_triggers__stl(vlSelfRef.__VstlTriggered, "stl"s);
#endif
            VL_FATAL_MT("sv/fsqrt_3.sv", 3, "", "Settle region did not converge after 100 tries");
        }
        __VstlIterCount = ((IData)(1U) + __VstlIterCount);
    } while (Vfsqrt_3___024root___eval_phase__stl(vlSelf));
}

VL_ATTR_COLD void Vfsqrt_3___024root___eval_triggers__stl(Vfsqrt_3___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfsqrt_3___024root___eval_triggers__stl\n"); );
    Vfsqrt_3__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.__VstlTriggered[0U] = ((0xfffffffffffffffeULL 
                                      & vlSelfRef.__VstlTriggered
                                      [0U]) | (IData)((IData)(vlSelfRef.__VstlFirstIteration)));
    vlSelfRef.__VstlFirstIteration = 0U;
#ifdef VL_DEBUG
    if (VL_UNLIKELY(vlSymsp->_vm_contextp__->debug())) {
        Vfsqrt_3___024root___dump_triggers__stl(vlSelfRef.__VstlTriggered, "stl"s);
    }
#endif
}

VL_ATTR_COLD bool Vfsqrt_3___024root___trigger_anySet__stl(const VlUnpacked<QData/*63:0*/, 1> &in);

#ifdef VL_DEBUG
VL_ATTR_COLD void Vfsqrt_3___024root___dump_triggers__stl(const VlUnpacked<QData/*63:0*/, 1> &triggers, const std::string &tag) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfsqrt_3___024root___dump_triggers__stl\n"); );
    // Body
    if ((1U & (~ (IData)(Vfsqrt_3___024root___trigger_anySet__stl(triggers))))) {
        VL_DBG_MSGS("         No '" + tag + "' region triggers active\n");
    }
    if ((1U & (IData)(triggers[0U]))) {
        VL_DBG_MSGS("         '" + tag + "' region trigger index 0 is active: Internal 'stl' trigger - first iteration\n");
    }
}
#endif  // VL_DEBUG

VL_ATTR_COLD bool Vfsqrt_3___024root___trigger_anySet__stl(const VlUnpacked<QData/*63:0*/, 1> &in) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfsqrt_3___024root___trigger_anySet__stl\n"); );
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

VL_ATTR_COLD void Vfsqrt_3___024root___stl_sequent__TOP__0(Vfsqrt_3___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfsqrt_3___024root___stl_sequent__TOP__0\n"); );
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
    // Body
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
}

VL_ATTR_COLD void Vfsqrt_3___024root___eval_stl(Vfsqrt_3___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfsqrt_3___024root___eval_stl\n"); );
    Vfsqrt_3__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((1ULL & vlSelfRef.__VstlTriggered[0U])) {
        Vfsqrt_3___024root___stl_sequent__TOP__0(vlSelf);
    }
}

VL_ATTR_COLD bool Vfsqrt_3___024root___eval_phase__stl(Vfsqrt_3___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfsqrt_3___024root___eval_phase__stl\n"); );
    Vfsqrt_3__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    CData/*0:0*/ __VstlExecute;
    // Body
    Vfsqrt_3___024root___eval_triggers__stl(vlSelf);
    __VstlExecute = Vfsqrt_3___024root___trigger_anySet__stl(vlSelfRef.__VstlTriggered);
    if (__VstlExecute) {
        Vfsqrt_3___024root___eval_stl(vlSelf);
    }
    return (__VstlExecute);
}

bool Vfsqrt_3___024root___trigger_anySet__act(const VlUnpacked<QData/*63:0*/, 1> &in);

#ifdef VL_DEBUG
VL_ATTR_COLD void Vfsqrt_3___024root___dump_triggers__act(const VlUnpacked<QData/*63:0*/, 1> &triggers, const std::string &tag) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfsqrt_3___024root___dump_triggers__act\n"); );
    // Body
    if ((1U & (~ (IData)(Vfsqrt_3___024root___trigger_anySet__act(triggers))))) {
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

VL_ATTR_COLD void Vfsqrt_3___024root___ctor_var_reset(Vfsqrt_3___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfsqrt_3___024root___ctor_var_reset\n"); );
    Vfsqrt_3__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    const uint64_t __VscopeHash = VL_MURMUR64_HASH(vlSelf->name());
    vlSelf->clk = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 16707436170211756652ull);
    vlSelf->rst_n = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 1638864771569018232ull);
    vlSelf->input_a = VL_SCOPED_RAND_RESET_I(32, __VscopeHash, 17200245311843468596ull);
    vlSelf->input_valid = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 4270309033785105452ull);
    vlSelf->result = VL_SCOPED_RAND_RESET_I(32, __VscopeHash, 16664408842984530663ull);
    vlSelf->out_valid = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 2886291494070200219ull);
    for (int __Vi0 = 0; __Vi0 < 1024; ++__Vi0) {
        vlSelf->fsqrt__DOT__lut[__Vi0] = VL_SCOPED_RAND_RESET_I(24, __VscopeHash, 18416131472297124181ull);
    }
    for (int __Vi0 = 0; __Vi0 < 1024; ++__Vi0) {
        vlSelf->fsqrt__DOT__lut_sq[__Vi0] = VL_SCOPED_RAND_RESET_I(24, __VscopeHash, 5807413673520652772ull);
    }
    vlSelf->fsqrt__DOT__valid_reg = VL_SCOPED_RAND_RESET_I(3, __VscopeHash, 14854446212445242238ull);
    vlSelf->fsqrt__DOT__is_zero_reg = VL_SCOPED_RAND_RESET_I(3, __VscopeHash, 17153357398428623010ull);
    vlSelf->fsqrt__DOT__is_abnormal_reg = VL_SCOPED_RAND_RESET_I(3, __VscopeHash, 12299482336274206800ull);
    vlSelf->fsqrt__DOT__exp_out = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 11648861824383624040ull);
    vlSelf->fsqrt__DOT__sign_out = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 2223855168288774962ull);
    vlSelf->fsqrt__DOT__a_fixed = VL_SCOPED_RAND_RESET_I(24, __VscopeHash, 5067013592607736311ull);
    vlSelf->fsqrt__DOT__x_0 = VL_SCOPED_RAND_RESET_I(24, __VscopeHash, 10942218857830781657ull);
    vlSelf->fsqrt__DOT__x0_x0 = VL_SCOPED_RAND_RESET_I(24, __VscopeHash, 429872014879837948ull);
    vlSelf->fsqrt__DOT__a_x0_reg = VL_SCOPED_RAND_RESET_I(24, __VscopeHash, 7019772981331828170ull);
    vlSelf->fsqrt__DOT__delta_reg = VL_SCOPED_RAND_RESET_I(18, __VscopeHash, 8593837227384477054ull);
    vlSelf->fsqrt__DOT__exp_reg = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 404177382420583547ull);
    vlSelf->fsqrt__DOT__exp_reg_minus = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 203737193833666274ull);
    vlSelf->fsqrt__DOT__sign_reg = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 10442850834461319891ull);
    vlSelf->fsqrt__DOT__exp_final = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 11720653065577105231ull);
    vlSelf->fsqrt__DOT__mant_final = VL_SCOPED_RAND_RESET_I(23, __VscopeHash, 2097299731906211212ull);
    vlSelf->fsqrt__DOT__unnamedblk2__DOT__delta_24 = VL_SCOPED_RAND_RESET_I(24, __VscopeHash, 15409006108850683690ull);
    for (int __Vi0 = 0; __Vi0 < 1; ++__Vi0) {
        vlSelf->__VstlTriggered[__Vi0] = 0;
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
