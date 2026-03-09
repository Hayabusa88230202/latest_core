// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vitof.h for the primary calling header

#include "Vitof__pch.h"

VL_ATTR_COLD void Vitof___024root___eval_static(Vitof___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vitof___024root___eval_static\n"); );
    Vitof__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.__Vtrigprevexpr___TOP__clk__0 = vlSelfRef.clk;
}

VL_ATTR_COLD void Vitof___024root___eval_initial(Vitof___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vitof___024root___eval_initial\n"); );
    Vitof__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
}

VL_ATTR_COLD void Vitof___024root___eval_final(Vitof___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vitof___024root___eval_final\n"); );
    Vitof__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vitof___024root___dump_triggers__stl(const VlUnpacked<QData/*63:0*/, 1> &triggers, const std::string &tag);
#endif  // VL_DEBUG
VL_ATTR_COLD bool Vitof___024root___eval_phase__stl(Vitof___024root* vlSelf);

VL_ATTR_COLD void Vitof___024root___eval_settle(Vitof___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vitof___024root___eval_settle\n"); );
    Vitof__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    IData/*31:0*/ __VstlIterCount;
    // Body
    __VstlIterCount = 0U;
    vlSelfRef.__VstlFirstIteration = 1U;
    do {
        if (VL_UNLIKELY(((0x00000064U < __VstlIterCount)))) {
#ifdef VL_DEBUG
            Vitof___024root___dump_triggers__stl(vlSelfRef.__VstlTriggered, "stl"s);
#endif
            VL_FATAL_MT("sv/itof.sv", 3, "", "Settle region did not converge after 100 tries");
        }
        __VstlIterCount = ((IData)(1U) + __VstlIterCount);
    } while (Vitof___024root___eval_phase__stl(vlSelf));
}

VL_ATTR_COLD void Vitof___024root___eval_triggers__stl(Vitof___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vitof___024root___eval_triggers__stl\n"); );
    Vitof__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.__VstlTriggered[0U] = ((0xfffffffffffffffeULL 
                                      & vlSelfRef.__VstlTriggered
                                      [0U]) | (IData)((IData)(vlSelfRef.__VstlFirstIteration)));
    vlSelfRef.__VstlFirstIteration = 0U;
#ifdef VL_DEBUG
    if (VL_UNLIKELY(vlSymsp->_vm_contextp__->debug())) {
        Vitof___024root___dump_triggers__stl(vlSelfRef.__VstlTriggered, "stl"s);
    }
#endif
}

VL_ATTR_COLD bool Vitof___024root___trigger_anySet__stl(const VlUnpacked<QData/*63:0*/, 1> &in);

#ifdef VL_DEBUG
VL_ATTR_COLD void Vitof___024root___dump_triggers__stl(const VlUnpacked<QData/*63:0*/, 1> &triggers, const std::string &tag) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vitof___024root___dump_triggers__stl\n"); );
    // Body
    if ((1U & (~ (IData)(Vitof___024root___trigger_anySet__stl(triggers))))) {
        VL_DBG_MSGS("         No '" + tag + "' region triggers active\n");
    }
    if ((1U & (IData)(triggers[0U]))) {
        VL_DBG_MSGS("         '" + tag + "' region trigger index 0 is active: Internal 'stl' trigger - first iteration\n");
    }
}
#endif  // VL_DEBUG

VL_ATTR_COLD bool Vitof___024root___trigger_anySet__stl(const VlUnpacked<QData/*63:0*/, 1> &in) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vitof___024root___trigger_anySet__stl\n"); );
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

VL_ATTR_COLD void Vitof___024root___stl_sequent__TOP__0(Vitof___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vitof___024root___stl_sequent__TOP__0\n"); );
    Vitof__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((0U == vlSelfRef.itof__DOT__s2_abs_i)) {
        vlSelfRef.itof__DOT__next_exp = 0U;
        vlSelfRef.itof__DOT__next_frac = 0U;
    } else {
        vlSelfRef.itof__DOT__unnamedblk1__DOT__temp_exp 
            = (0x000000ffU & ((IData)(0x7fU) + ((IData)(0x1fU) 
                                                - (IData)(vlSelfRef.itof__DOT__s2_lzc))));
        vlSelfRef.itof__DOT__shifted_mant = (vlSelfRef.itof__DOT__s2_abs_i 
                                             << (IData)(vlSelfRef.itof__DOT__s2_lzc));
        vlSelfRef.itof__DOT__guard = (1U & (vlSelfRef.itof__DOT__shifted_mant 
                                            >> 7U));
        vlSelfRef.itof__DOT__round = (1U & (vlSelfRef.itof__DOT__shifted_mant 
                                            >> 6U));
        vlSelfRef.itof__DOT__sticky = (0U != (0x0000003fU 
                                              & vlSelfRef.itof__DOT__shifted_mant));
        vlSelfRef.itof__DOT__lsb = (1U & (vlSelfRef.itof__DOT__shifted_mant 
                                          >> 8U));
        if (((IData)(vlSelfRef.itof__DOT__guard) & 
             (((IData)(vlSelfRef.itof__DOT__round) 
               | (IData)(vlSelfRef.itof__DOT__sticky)) 
              | (IData)(vlSelfRef.itof__DOT__lsb)))) {
            vlSelfRef.itof__DOT__next_exp = (0x000000ffU 
                                             & (((IData)(1U) 
                                                 + 
                                                 (((IData)(vlSelfRef.itof__DOT__unnamedblk1__DOT__temp_exp) 
                                                   << 0x00000017U) 
                                                  | (0x007fffffU 
                                                     & (vlSelfRef.itof__DOT__shifted_mant 
                                                        >> 8U)))) 
                                                >> 0x00000017U));
            vlSelfRef.itof__DOT__next_frac = (0x007fffffU 
                                              & ((IData)(1U) 
                                                 + 
                                                 (vlSelfRef.itof__DOT__shifted_mant 
                                                  >> 8U)));
        } else {
            vlSelfRef.itof__DOT__next_exp = vlSelfRef.itof__DOT__unnamedblk1__DOT__temp_exp;
            vlSelfRef.itof__DOT__next_frac = (0x007fffffU 
                                              & (vlSelfRef.itof__DOT__shifted_mant 
                                                 >> 8U));
        }
    }
}

VL_ATTR_COLD void Vitof___024root___eval_stl(Vitof___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vitof___024root___eval_stl\n"); );
    Vitof__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((1ULL & vlSelfRef.__VstlTriggered[0U])) {
        Vitof___024root___stl_sequent__TOP__0(vlSelf);
    }
}

VL_ATTR_COLD bool Vitof___024root___eval_phase__stl(Vitof___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vitof___024root___eval_phase__stl\n"); );
    Vitof__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    CData/*0:0*/ __VstlExecute;
    // Body
    Vitof___024root___eval_triggers__stl(vlSelf);
    __VstlExecute = Vitof___024root___trigger_anySet__stl(vlSelfRef.__VstlTriggered);
    if (__VstlExecute) {
        Vitof___024root___eval_stl(vlSelf);
    }
    return (__VstlExecute);
}

bool Vitof___024root___trigger_anySet__act(const VlUnpacked<QData/*63:0*/, 1> &in);

#ifdef VL_DEBUG
VL_ATTR_COLD void Vitof___024root___dump_triggers__act(const VlUnpacked<QData/*63:0*/, 1> &triggers, const std::string &tag) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vitof___024root___dump_triggers__act\n"); );
    // Body
    if ((1U & (~ (IData)(Vitof___024root___trigger_anySet__act(triggers))))) {
        VL_DBG_MSGS("         No '" + tag + "' region triggers active\n");
    }
    if ((1U & (IData)(triggers[0U]))) {
        VL_DBG_MSGS("         '" + tag + "' region trigger index 0 is active: @(posedge clk)\n");
    }
}
#endif  // VL_DEBUG

VL_ATTR_COLD void Vitof___024root___ctor_var_reset(Vitof___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vitof___024root___ctor_var_reset\n"); );
    Vitof__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    const uint64_t __VscopeHash = VL_MURMUR64_HASH(vlSelf->name());
    vlSelf->clk = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 16707436170211756652ull);
    vlSelf->rst_n = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 1638864771569018232ull);
    vlSelf->in_i = VL_SCOPED_RAND_RESET_I(32, __VscopeHash, 10846626665951073823ull);
    vlSelf->input_valid = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 4270309033785105452ull);
    vlSelf->out_f = VL_SCOPED_RAND_RESET_I(32, __VscopeHash, 10010808663496648567ull);
    vlSelf->out_valid = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 2886291494070200219ull);
    vlSelf->itof__DOT__s1_abs_i = VL_SCOPED_RAND_RESET_I(32, __VscopeHash, 11624773575419394603ull);
    vlSelf->itof__DOT__s1_sign = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 1126403881222899416ull);
    vlSelf->itof__DOT__s1_valid = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 3064365656443258339ull);
    vlSelf->itof__DOT__s2_lzc = VL_SCOPED_RAND_RESET_I(5, __VscopeHash, 11799351883177459496ull);
    vlSelf->itof__DOT__s2_abs_i = VL_SCOPED_RAND_RESET_I(32, __VscopeHash, 562014536224099088ull);
    vlSelf->itof__DOT__s2_sign = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 13558313540530627336ull);
    vlSelf->itof__DOT__s2_valid = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 13375511154758242757ull);
    vlSelf->itof__DOT__next_exp = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 14403775699060881832ull);
    vlSelf->itof__DOT__next_frac = VL_SCOPED_RAND_RESET_I(23, __VscopeHash, 2405327720051055604ull);
    vlSelf->itof__DOT__shifted_mant = VL_SCOPED_RAND_RESET_I(32, __VscopeHash, 8214489494293880089ull);
    vlSelf->itof__DOT__guard = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 7041507525825489819ull);
    vlSelf->itof__DOT__round = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 6903845226569278816ull);
    vlSelf->itof__DOT__sticky = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 2239962353138882529ull);
    vlSelf->itof__DOT__lsb = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 2139301497733401549ull);
    vlSelf->itof__DOT__unnamedblk1__DOT__temp_exp = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 885814212666964663ull);
    for (int __Vi0 = 0; __Vi0 < 1; ++__Vi0) {
        vlSelf->__VstlTriggered[__Vi0] = 0;
    }
    for (int __Vi0 = 0; __Vi0 < 1; ++__Vi0) {
        vlSelf->__VactTriggered[__Vi0] = 0;
    }
    vlSelf->__Vtrigprevexpr___TOP__clk__0 = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 9526919608049418986ull);
    for (int __Vi0 = 0; __Vi0 < 1; ++__Vi0) {
        vlSelf->__VnbaTriggered[__Vi0] = 0;
    }
}
