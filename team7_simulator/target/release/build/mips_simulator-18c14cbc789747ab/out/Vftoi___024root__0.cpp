// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vftoi.h for the primary calling header

#include "Vftoi__pch.h"

#ifdef VL_DEBUG
VL_ATTR_COLD void Vftoi___024root___dump_triggers__act(const VlUnpacked<QData/*63:0*/, 1> &triggers, const std::string &tag);
#endif  // VL_DEBUG

void Vftoi___024root___eval_triggers__act(Vftoi___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vftoi___024root___eval_triggers__act\n"); );
    Vftoi__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.__VactTriggered[0U] = (QData)((IData)(
                                                    ((IData)(vlSelfRef.clk) 
                                                     & (~ (IData)(vlSelfRef.__Vtrigprevexpr___TOP__clk__0)))));
    vlSelfRef.__Vtrigprevexpr___TOP__clk__0 = vlSelfRef.clk;
#ifdef VL_DEBUG
    if (VL_UNLIKELY(vlSymsp->_vm_contextp__->debug())) {
        Vftoi___024root___dump_triggers__act(vlSelfRef.__VactTriggered, "act"s);
    }
#endif
}

bool Vftoi___024root___trigger_anySet__act(const VlUnpacked<QData/*63:0*/, 1> &in) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vftoi___024root___trigger_anySet__act\n"); );
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

void Vftoi___024root___nba_sequent__TOP__0(Vftoi___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vftoi___024root___nba_sequent__TOP__0\n"); );
    Vftoi__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.out_valid = ((IData)(vlSelfRef.rst_n) 
                           && (IData)(vlSelfRef.ftoi__DOT__s1_valid));
    if (vlSelfRef.rst_n) {
        vlSelfRef.out_i = ((IData)(vlSelfRef.ftoi__DOT__s1_ovf)
                            ? ((IData)(vlSelfRef.ftoi__DOT__s1_sign)
                                ? 0x80000000U : 0x7fffffffU)
                            : ((IData)(vlSelfRef.ftoi__DOT__s1_sign)
                                ? ((IData)(1U) + (~ vlSelfRef.ftoi__DOT__s1_abs_int))
                                : vlSelfRef.ftoi__DOT__s1_abs_int));
        if (vlSelfRef.input_valid) {
            vlSelfRef.ftoi__DOT__s1_valid = vlSelfRef.input_valid;
            vlSelfRef.ftoi__DOT__s1_ovf = ((0x7fU <= 
                                            (0x000000ffU 
                                             & (vlSelfRef.in_f 
                                                >> 0x00000017U))) 
                                           && ((0x9eU 
                                                <= 
                                                (0x000000ffU 
                                                 & (vlSelfRef.in_f 
                                                    >> 0x00000017U))) 
                                               && (1U 
                                                   & (~ (IData)(
                                                                (0xcf000000U 
                                                                 == vlSelfRef.in_f))))));
            vlSelfRef.ftoi__DOT__s1_sign = (vlSelfRef.in_f 
                                            >> 0x1fU);
            vlSelfRef.ftoi__DOT__s1_abs_int = ((0x7fU 
                                                > (0x000000ffU 
                                                   & (vlSelfRef.in_f 
                                                      >> 0x00000017U)))
                                                ? 0U
                                                : (
                                                   (0x9eU 
                                                    <= 
                                                    (0x000000ffU 
                                                     & (vlSelfRef.in_f 
                                                        >> 0x00000017U)))
                                                    ? 
                                                   ((IData)(
                                                            (0xcf000000U 
                                                             == vlSelfRef.in_f))
                                                     ? 0x80000000U
                                                     : 0U)
                                                    : 
                                                   ((0x96U 
                                                     <= 
                                                     (0x000000ffU 
                                                      & (vlSelfRef.in_f 
                                                         >> 0x00000017U)))
                                                     ? 
                                                    VL_SHIFTL_III(32,32,8, 
                                                                  (0x00800000U 
                                                                   | (0x007fffffU 
                                                                      & vlSelfRef.in_f)), 
                                                                  (0x000000ffU 
                                                                   & ((vlSelfRef.in_f 
                                                                       >> 0x00000017U) 
                                                                      - (IData)(0x96U))))
                                                     : 
                                                    VL_SHIFTR_III(32,32,8, 
                                                                  (0x00800000U 
                                                                   | (0x007fffffU 
                                                                      & vlSelfRef.in_f)), 
                                                                  (0x000000ffU 
                                                                   & ((IData)(0x96U) 
                                                                      - 
                                                                      (vlSelfRef.in_f 
                                                                       >> 0x00000017U)))))));
        }
    } else {
        vlSelfRef.out_i = 0U;
        vlSelfRef.ftoi__DOT__s1_valid = 0U;
        vlSelfRef.ftoi__DOT__s1_ovf = 0U;
        vlSelfRef.ftoi__DOT__s1_sign = 0U;
        vlSelfRef.ftoi__DOT__s1_abs_int = 0U;
    }
}

void Vftoi___024root___eval_nba(Vftoi___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vftoi___024root___eval_nba\n"); );
    Vftoi__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((1ULL & vlSelfRef.__VnbaTriggered[0U])) {
        Vftoi___024root___nba_sequent__TOP__0(vlSelf);
    }
}

void Vftoi___024root___trigger_orInto__act(VlUnpacked<QData/*63:0*/, 1> &out, const VlUnpacked<QData/*63:0*/, 1> &in) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vftoi___024root___trigger_orInto__act\n"); );
    // Locals
    IData/*31:0*/ n;
    // Body
    n = 0U;
    do {
        out[n] = (out[n] | in[n]);
        n = ((IData)(1U) + n);
    } while ((1U > n));
}

bool Vftoi___024root___eval_phase__act(Vftoi___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vftoi___024root___eval_phase__act\n"); );
    Vftoi__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    Vftoi___024root___eval_triggers__act(vlSelf);
    Vftoi___024root___trigger_orInto__act(vlSelfRef.__VnbaTriggered, vlSelfRef.__VactTriggered);
    return (0U);
}

void Vftoi___024root___trigger_clear__act(VlUnpacked<QData/*63:0*/, 1> &out) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vftoi___024root___trigger_clear__act\n"); );
    // Locals
    IData/*31:0*/ n;
    // Body
    n = 0U;
    do {
        out[n] = 0ULL;
        n = ((IData)(1U) + n);
    } while ((1U > n));
}

bool Vftoi___024root___eval_phase__nba(Vftoi___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vftoi___024root___eval_phase__nba\n"); );
    Vftoi__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    CData/*0:0*/ __VnbaExecute;
    // Body
    __VnbaExecute = Vftoi___024root___trigger_anySet__act(vlSelfRef.__VnbaTriggered);
    if (__VnbaExecute) {
        Vftoi___024root___eval_nba(vlSelf);
        Vftoi___024root___trigger_clear__act(vlSelfRef.__VnbaTriggered);
    }
    return (__VnbaExecute);
}

void Vftoi___024root___eval(Vftoi___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vftoi___024root___eval\n"); );
    Vftoi__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    IData/*31:0*/ __VnbaIterCount;
    // Body
    __VnbaIterCount = 0U;
    do {
        if (VL_UNLIKELY(((0x00000064U < __VnbaIterCount)))) {
#ifdef VL_DEBUG
            Vftoi___024root___dump_triggers__act(vlSelfRef.__VnbaTriggered, "nba"s);
#endif
            VL_FATAL_MT("sv/ftoi.sv", 3, "", "NBA region did not converge after 100 tries");
        }
        __VnbaIterCount = ((IData)(1U) + __VnbaIterCount);
        vlSelfRef.__VactIterCount = 0U;
        do {
            if (VL_UNLIKELY(((0x00000064U < vlSelfRef.__VactIterCount)))) {
#ifdef VL_DEBUG
                Vftoi___024root___dump_triggers__act(vlSelfRef.__VactTriggered, "act"s);
#endif
                VL_FATAL_MT("sv/ftoi.sv", 3, "", "Active region did not converge after 100 tries");
            }
            vlSelfRef.__VactIterCount = ((IData)(1U) 
                                         + vlSelfRef.__VactIterCount);
        } while (Vftoi___024root___eval_phase__act(vlSelf));
    } while (Vftoi___024root___eval_phase__nba(vlSelf));
}

#ifdef VL_DEBUG
void Vftoi___024root___eval_debug_assertions(Vftoi___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vftoi___024root___eval_debug_assertions\n"); );
    Vftoi__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
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
