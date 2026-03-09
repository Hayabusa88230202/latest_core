// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vftoi.h for the primary calling header

#include "Vftoi__pch.h"

VL_ATTR_COLD void Vftoi___024root___eval_static(Vftoi___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vftoi___024root___eval_static\n"); );
    Vftoi__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.__Vtrigprevexpr___TOP__clk__0 = vlSelfRef.clk;
}

VL_ATTR_COLD void Vftoi___024root___eval_initial(Vftoi___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vftoi___024root___eval_initial\n"); );
    Vftoi__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
}

VL_ATTR_COLD void Vftoi___024root___eval_final(Vftoi___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vftoi___024root___eval_final\n"); );
    Vftoi__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
}

VL_ATTR_COLD void Vftoi___024root___eval_settle(Vftoi___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vftoi___024root___eval_settle\n"); );
    Vftoi__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
}

bool Vftoi___024root___trigger_anySet__act(const VlUnpacked<QData/*63:0*/, 1> &in);

#ifdef VL_DEBUG
VL_ATTR_COLD void Vftoi___024root___dump_triggers__act(const VlUnpacked<QData/*63:0*/, 1> &triggers, const std::string &tag) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vftoi___024root___dump_triggers__act\n"); );
    // Body
    if ((1U & (~ (IData)(Vftoi___024root___trigger_anySet__act(triggers))))) {
        VL_DBG_MSGS("         No '" + tag + "' region triggers active\n");
    }
    if ((1U & (IData)(triggers[0U]))) {
        VL_DBG_MSGS("         '" + tag + "' region trigger index 0 is active: @(posedge clk)\n");
    }
}
#endif  // VL_DEBUG

VL_ATTR_COLD void Vftoi___024root___ctor_var_reset(Vftoi___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vftoi___024root___ctor_var_reset\n"); );
    Vftoi__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    const uint64_t __VscopeHash = VL_MURMUR64_HASH(vlSelf->name());
    vlSelf->clk = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 16707436170211756652ull);
    vlSelf->rst_n = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 1638864771569018232ull);
    vlSelf->in_f = VL_SCOPED_RAND_RESET_I(32, __VscopeHash, 10511732710955025453ull);
    vlSelf->input_valid = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 4270309033785105452ull);
    vlSelf->out_i = VL_SCOPED_RAND_RESET_I(32, __VscopeHash, 15869654417598851880ull);
    vlSelf->out_valid = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 2886291494070200219ull);
    vlSelf->ftoi__DOT__s1_valid = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 16370238107411341268ull);
    vlSelf->ftoi__DOT__s1_sign = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 14071652493172848014ull);
    vlSelf->ftoi__DOT__s1_abs_int = VL_SCOPED_RAND_RESET_I(32, __VscopeHash, 10497006301809626066ull);
    vlSelf->ftoi__DOT__s1_ovf = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 3798264996947479421ull);
    for (int __Vi0 = 0; __Vi0 < 1; ++__Vi0) {
        vlSelf->__VactTriggered[__Vi0] = 0;
    }
    vlSelf->__Vtrigprevexpr___TOP__clk__0 = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 9526919608049418986ull);
    for (int __Vi0 = 0; __Vi0 < 1; ++__Vi0) {
        vlSelf->__VnbaTriggered[__Vi0] = 0;
    }
}
