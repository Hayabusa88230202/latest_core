// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vitof.h for the primary calling header

#include "Vitof__pch.h"

#ifdef VL_DEBUG
VL_ATTR_COLD void Vitof___024root___dump_triggers__act(const VlUnpacked<QData/*63:0*/, 1> &triggers, const std::string &tag);
#endif  // VL_DEBUG

void Vitof___024root___eval_triggers__act(Vitof___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vitof___024root___eval_triggers__act\n"); );
    Vitof__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.__VactTriggered[0U] = (QData)((IData)(
                                                    ((IData)(vlSelfRef.clk) 
                                                     & (~ (IData)(vlSelfRef.__Vtrigprevexpr___TOP__clk__0)))));
    vlSelfRef.__Vtrigprevexpr___TOP__clk__0 = vlSelfRef.clk;
#ifdef VL_DEBUG
    if (VL_UNLIKELY(vlSymsp->_vm_contextp__->debug())) {
        Vitof___024root___dump_triggers__act(vlSelfRef.__VactTriggered, "act"s);
    }
#endif
}

bool Vitof___024root___trigger_anySet__act(const VlUnpacked<QData/*63:0*/, 1> &in) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vitof___024root___trigger_anySet__act\n"); );
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

void Vitof___024root___nba_sequent__TOP__0(Vitof___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vitof___024root___nba_sequent__TOP__0\n"); );
    Vitof__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    CData/*4:0*/ __Vfunc_itof__DOT__lzc32__0__Vfuncout;
    __Vfunc_itof__DOT__lzc32__0__Vfuncout = 0;
    IData/*31:0*/ __Vfunc_itof__DOT__lzc32__0__v;
    __Vfunc_itof__DOT__lzc32__0__v = 0;
    // Body
    vlSelfRef.out_valid = ((IData)(vlSelfRef.rst_n) 
                           && (IData)(vlSelfRef.itof__DOT__s2_valid));
    vlSelfRef.out_f = ((IData)(vlSelfRef.rst_n) ? (
                                                   (0U 
                                                    == vlSelfRef.itof__DOT__s2_abs_i)
                                                    ? 0U
                                                    : 
                                                   (((IData)(vlSelfRef.itof__DOT__s2_sign) 
                                                     << 0x0000001fU) 
                                                    | (((IData)(vlSelfRef.itof__DOT__next_exp) 
                                                        << 0x00000017U) 
                                                       | vlSelfRef.itof__DOT__next_frac)))
                        : 0U);
    if (vlSelfRef.rst_n) {
        vlSelfRef.itof__DOT__s2_valid = vlSelfRef.itof__DOT__s1_valid;
        vlSelfRef.itof__DOT__s2_sign = vlSelfRef.itof__DOT__s1_sign;
        vlSelfRef.itof__DOT__s2_abs_i = vlSelfRef.itof__DOT__s1_abs_i;
        __Vfunc_itof__DOT__lzc32__0__v = vlSelfRef.itof__DOT__s1_abs_i;
        {
            if ((__Vfunc_itof__DOT__lzc32__0__v >> 0x1fU)) {
                __Vfunc_itof__DOT__lzc32__0__Vfuncout = 0U;
                goto __Vlabel0;
            }
            if ((0x40000000U & __Vfunc_itof__DOT__lzc32__0__v)) {
                __Vfunc_itof__DOT__lzc32__0__Vfuncout = 1U;
                goto __Vlabel0;
            }
            if ((0x20000000U & __Vfunc_itof__DOT__lzc32__0__v)) {
                __Vfunc_itof__DOT__lzc32__0__Vfuncout = 2U;
                goto __Vlabel0;
            }
            if ((0x10000000U & __Vfunc_itof__DOT__lzc32__0__v)) {
                __Vfunc_itof__DOT__lzc32__0__Vfuncout = 3U;
                goto __Vlabel0;
            }
            if ((0x08000000U & __Vfunc_itof__DOT__lzc32__0__v)) {
                __Vfunc_itof__DOT__lzc32__0__Vfuncout = 4U;
                goto __Vlabel0;
            }
            if ((0x04000000U & __Vfunc_itof__DOT__lzc32__0__v)) {
                __Vfunc_itof__DOT__lzc32__0__Vfuncout = 5U;
                goto __Vlabel0;
            }
            if ((0x02000000U & __Vfunc_itof__DOT__lzc32__0__v)) {
                __Vfunc_itof__DOT__lzc32__0__Vfuncout = 6U;
                goto __Vlabel0;
            }
            if ((0x01000000U & __Vfunc_itof__DOT__lzc32__0__v)) {
                __Vfunc_itof__DOT__lzc32__0__Vfuncout = 7U;
                goto __Vlabel0;
            }
            if ((0x00800000U & __Vfunc_itof__DOT__lzc32__0__v)) {
                __Vfunc_itof__DOT__lzc32__0__Vfuncout = 8U;
                goto __Vlabel0;
            }
            if ((0x00400000U & __Vfunc_itof__DOT__lzc32__0__v)) {
                __Vfunc_itof__DOT__lzc32__0__Vfuncout = 9U;
                goto __Vlabel0;
            }
            if ((0x00200000U & __Vfunc_itof__DOT__lzc32__0__v)) {
                __Vfunc_itof__DOT__lzc32__0__Vfuncout = 0x0aU;
                goto __Vlabel0;
            }
            if ((0x00100000U & __Vfunc_itof__DOT__lzc32__0__v)) {
                __Vfunc_itof__DOT__lzc32__0__Vfuncout = 0x0bU;
                goto __Vlabel0;
            }
            if ((0x00080000U & __Vfunc_itof__DOT__lzc32__0__v)) {
                __Vfunc_itof__DOT__lzc32__0__Vfuncout = 0x0cU;
                goto __Vlabel0;
            }
            if ((0x00040000U & __Vfunc_itof__DOT__lzc32__0__v)) {
                __Vfunc_itof__DOT__lzc32__0__Vfuncout = 0x0dU;
                goto __Vlabel0;
            }
            if ((0x00020000U & __Vfunc_itof__DOT__lzc32__0__v)) {
                __Vfunc_itof__DOT__lzc32__0__Vfuncout = 0x0eU;
                goto __Vlabel0;
            }
            if ((0x00010000U & __Vfunc_itof__DOT__lzc32__0__v)) {
                __Vfunc_itof__DOT__lzc32__0__Vfuncout = 0x0fU;
                goto __Vlabel0;
            }
            if ((0x00008000U & __Vfunc_itof__DOT__lzc32__0__v)) {
                __Vfunc_itof__DOT__lzc32__0__Vfuncout = 0x10U;
                goto __Vlabel0;
            }
            if ((0x00004000U & __Vfunc_itof__DOT__lzc32__0__v)) {
                __Vfunc_itof__DOT__lzc32__0__Vfuncout = 0x11U;
                goto __Vlabel0;
            }
            if ((0x00002000U & __Vfunc_itof__DOT__lzc32__0__v)) {
                __Vfunc_itof__DOT__lzc32__0__Vfuncout = 0x12U;
                goto __Vlabel0;
            }
            if ((0x00001000U & __Vfunc_itof__DOT__lzc32__0__v)) {
                __Vfunc_itof__DOT__lzc32__0__Vfuncout = 0x13U;
                goto __Vlabel0;
            }
            if ((0x00000800U & __Vfunc_itof__DOT__lzc32__0__v)) {
                __Vfunc_itof__DOT__lzc32__0__Vfuncout = 0x14U;
                goto __Vlabel0;
            }
            if ((0x00000400U & __Vfunc_itof__DOT__lzc32__0__v)) {
                __Vfunc_itof__DOT__lzc32__0__Vfuncout = 0x15U;
                goto __Vlabel0;
            }
            if ((0x00000200U & __Vfunc_itof__DOT__lzc32__0__v)) {
                __Vfunc_itof__DOT__lzc32__0__Vfuncout = 0x16U;
                goto __Vlabel0;
            }
            if ((0x00000100U & __Vfunc_itof__DOT__lzc32__0__v)) {
                __Vfunc_itof__DOT__lzc32__0__Vfuncout = 0x17U;
                goto __Vlabel0;
            }
            if ((0x00000080U & __Vfunc_itof__DOT__lzc32__0__v)) {
                __Vfunc_itof__DOT__lzc32__0__Vfuncout = 0x18U;
                goto __Vlabel0;
            }
            if ((0x00000040U & __Vfunc_itof__DOT__lzc32__0__v)) {
                __Vfunc_itof__DOT__lzc32__0__Vfuncout = 0x19U;
                goto __Vlabel0;
            }
            if ((0x00000020U & __Vfunc_itof__DOT__lzc32__0__v)) {
                __Vfunc_itof__DOT__lzc32__0__Vfuncout = 0x1aU;
                goto __Vlabel0;
            }
            if ((0x00000010U & __Vfunc_itof__DOT__lzc32__0__v)) {
                __Vfunc_itof__DOT__lzc32__0__Vfuncout = 0x1bU;
                goto __Vlabel0;
            }
            if ((8U & __Vfunc_itof__DOT__lzc32__0__v)) {
                __Vfunc_itof__DOT__lzc32__0__Vfuncout = 0x1cU;
                goto __Vlabel0;
            }
            if ((4U & __Vfunc_itof__DOT__lzc32__0__v)) {
                __Vfunc_itof__DOT__lzc32__0__Vfuncout = 0x1dU;
                goto __Vlabel0;
            }
            if ((2U & __Vfunc_itof__DOT__lzc32__0__v)) {
                __Vfunc_itof__DOT__lzc32__0__Vfuncout = 0x1eU;
                goto __Vlabel0;
            }
            if ((1U & __Vfunc_itof__DOT__lzc32__0__v)) {
                __Vfunc_itof__DOT__lzc32__0__Vfuncout = 0x1fU;
                goto __Vlabel0;
            }
            __Vfunc_itof__DOT__lzc32__0__Vfuncout = 0x1fU;
            __Vlabel0: ;
        }
        vlSelfRef.itof__DOT__s2_lzc = __Vfunc_itof__DOT__lzc32__0__Vfuncout;
    } else {
        vlSelfRef.itof__DOT__s2_lzc = 0U;
        vlSelfRef.itof__DOT__s2_abs_i = 0U;
        vlSelfRef.itof__DOT__s2_sign = 0U;
        vlSelfRef.itof__DOT__s2_valid = 0U;
    }
    vlSelfRef.itof__DOT__s1_abs_i = ((IData)(vlSelfRef.rst_n)
                                      ? ((vlSelfRef.in_i 
                                          >> 0x1fU)
                                          ? ((IData)(1U) 
                                             + (~ vlSelfRef.in_i))
                                          : vlSelfRef.in_i)
                                      : 0U);
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
    vlSelfRef.itof__DOT__s1_valid = ((IData)(vlSelfRef.rst_n) 
                                     && (IData)(vlSelfRef.input_valid));
    vlSelfRef.itof__DOT__s1_sign = ((IData)(vlSelfRef.rst_n) 
                                    && (vlSelfRef.in_i 
                                        >> 0x1fU));
}

void Vitof___024root___eval_nba(Vitof___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vitof___024root___eval_nba\n"); );
    Vitof__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((1ULL & vlSelfRef.__VnbaTriggered[0U])) {
        Vitof___024root___nba_sequent__TOP__0(vlSelf);
    }
}

void Vitof___024root___trigger_orInto__act(VlUnpacked<QData/*63:0*/, 1> &out, const VlUnpacked<QData/*63:0*/, 1> &in) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vitof___024root___trigger_orInto__act\n"); );
    // Locals
    IData/*31:0*/ n;
    // Body
    n = 0U;
    do {
        out[n] = (out[n] | in[n]);
        n = ((IData)(1U) + n);
    } while ((1U > n));
}

bool Vitof___024root___eval_phase__act(Vitof___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vitof___024root___eval_phase__act\n"); );
    Vitof__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    Vitof___024root___eval_triggers__act(vlSelf);
    Vitof___024root___trigger_orInto__act(vlSelfRef.__VnbaTriggered, vlSelfRef.__VactTriggered);
    return (0U);
}

void Vitof___024root___trigger_clear__act(VlUnpacked<QData/*63:0*/, 1> &out) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vitof___024root___trigger_clear__act\n"); );
    // Locals
    IData/*31:0*/ n;
    // Body
    n = 0U;
    do {
        out[n] = 0ULL;
        n = ((IData)(1U) + n);
    } while ((1U > n));
}

bool Vitof___024root___eval_phase__nba(Vitof___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vitof___024root___eval_phase__nba\n"); );
    Vitof__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    CData/*0:0*/ __VnbaExecute;
    // Body
    __VnbaExecute = Vitof___024root___trigger_anySet__act(vlSelfRef.__VnbaTriggered);
    if (__VnbaExecute) {
        Vitof___024root___eval_nba(vlSelf);
        Vitof___024root___trigger_clear__act(vlSelfRef.__VnbaTriggered);
    }
    return (__VnbaExecute);
}

void Vitof___024root___eval(Vitof___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vitof___024root___eval\n"); );
    Vitof__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    IData/*31:0*/ __VnbaIterCount;
    // Body
    __VnbaIterCount = 0U;
    do {
        if (VL_UNLIKELY(((0x00000064U < __VnbaIterCount)))) {
#ifdef VL_DEBUG
            Vitof___024root___dump_triggers__act(vlSelfRef.__VnbaTriggered, "nba"s);
#endif
            VL_FATAL_MT("sv/itof.sv", 3, "", "NBA region did not converge after 100 tries");
        }
        __VnbaIterCount = ((IData)(1U) + __VnbaIterCount);
        vlSelfRef.__VactIterCount = 0U;
        do {
            if (VL_UNLIKELY(((0x00000064U < vlSelfRef.__VactIterCount)))) {
#ifdef VL_DEBUG
                Vitof___024root___dump_triggers__act(vlSelfRef.__VactTriggered, "act"s);
#endif
                VL_FATAL_MT("sv/itof.sv", 3, "", "Active region did not converge after 100 tries");
            }
            vlSelfRef.__VactIterCount = ((IData)(1U) 
                                         + vlSelfRef.__VactIterCount);
        } while (Vitof___024root___eval_phase__act(vlSelf));
    } while (Vitof___024root___eval_phase__nba(vlSelf));
}

#ifdef VL_DEBUG
void Vitof___024root___eval_debug_assertions(Vitof___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vitof___024root___eval_debug_assertions\n"); );
    Vitof__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
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
