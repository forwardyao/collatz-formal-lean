/-
  Collatz 形式化线 · 层 L3 主定理陈述
  ------------------------------------------------------------------
  编译状态：**未验证**（本机零编译）。其中带 `sorry` 的条目已在
  SORRY.md 与专项报告中逐条登记，本文档不宣称任何一条已通过类型检查。

  对应的人写证明见 proofs/首段连升全刻画_证明.md，二者应当逐条对齐。
  ------------------------------------------------------------------
-/
import Collatz.Basic

namespace Collatz

/-! ### H1 模 4 升降判据 -/

/-- 上升侧：n ≡ 3 (mod 4) ⟹ C n > n。 -/
theorem C_gt_self_of_mod4_three (n : Nat) (hn : IsOdd n) (h : n % 4 = 3) :
    n < C n := by
  obtain ⟨t, rfl⟩ : ∃ t, n = 4 * t + 3 := ⟨n / 4, by omega⟩
  have h3 : 3 * (4 * t + 3) + 1 = 2 * (2 * (3 * t + 2) + 1) := by omega
  have hkey : v2 (3 * (4 * t + 3) + 1) = 1 := by
    rw [h3, v2_two_mul_succ,
      v2_odd (show IsOdd (2 * (3 * t + 2) + 1) from by unfold IsOdd; omega)]
  have hC : C (4 * t + 3) = (3 * (4 * t + 3) + 1) / 2 := by
    unfold C
    rw [hkey]
    rfl
  rw [hC]
  omega

/-- 下降侧：n ≡ 1 (mod 4) 且 n > 1 ⟹ C n < n。 -/
theorem C_lt_self_of_mod4_one (n : Nat) (hn : IsOdd n) (h : n % 4 = 1) (h1 : 1 < n) :
    C n < n := by
  sorry

/-! ### H2 首段连升全刻画 -/

/-- C 的迭代（结构递归在 k 上，不依赖 `Nat.iterate` 是否在核心库中）。 -/
def itC : Nat → Nat → Nat
  | 0, n => n
  | k + 1, n => itC k (C n)

/-- 连升步数的递归定义（用燃料版，避免终止性证明）：r 由 `v2 (n+1) - 1` 给出，
    这里独立地按“每步比较大小”定义，用于与闭式对照。 -/
def riseRunFuel : Nat → Nat → Nat
  | 0, _ => 0
  | fuel + 1, n =>
    if n < C n then riseRunFuel fuel (C n) + 1 else 0

/-- 陈述（H2）：n 为奇数时，连升步数恰为 `v2 (n+1) - 1`。 -/
theorem riseRun_eq (n : Nat) (hn : IsOdd n) :
    riseRunFuel (v2 (n + 1)) n = v2 (n + 1) - 1 := by
  sorry

/-! ### H3 闭式 -/

/-- 陈述（H3）：n + 1 = 2^s * m（m 奇），则第 j 步（0 ≤ j ≤ s-1）为
    `3^j * 2^(s-j) * m - 1`。 -/
theorem iterate_closed_form (n s m j : Nat) (hd : Decomp n s m)
    (hs : 1 ≤ s) (hj : j ≤ s - 1) :
    itC j n = 3 ^ j * 2 ^ (s - j) * m - 1 := by
  sorry

/-! ### H4 恰好性 -/

/-- 陈述（H4a）：j < s-1 时迭代值 ≡ 3 (mod 4)，即仍在上升段。 -/
theorem iterate_mod4_three (n s m j : Nat) (hd : Decomp n s m)
    (hs : 1 ≤ s) (hj : j + 1 ≤ s - 1) :
    itC j n % 4 = 3 := by
  sorry

/-- 陈述（H4b）：第 s-1 步恰落 ≡ 1 (mod 4)，即上升段在此终止。 -/
theorem iterate_mod4_one (n s m : Nat) (hd : Decomp n s m) (hs : 1 ≤ s) :
    itC (s - 1) n % 4 = 1 := by
  sorry

/-! ### H5 梅森特例 -/

/-- 陈述（H5）：n = 2^k - 1 时 r = k-1，且第 j 步 = 3^j * 2^(k-j) - 1。 -/
theorem mersenne_riseRun (k : Nat) (hk : 1 ≤ k) :
    riseRunFuel k (2 ^ k - 1) = k - 1 := by
  sorry

end Collatz
