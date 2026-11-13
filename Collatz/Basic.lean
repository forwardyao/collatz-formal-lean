/-
  Collatz 形式化线 · 层级 L3 基础定义
  ------------------------------------------------------------------
  编译状态：**未验证**。本机无 Lean 工具链（lake/lean/elan 均不可用），
  本文件从未在本地经过类型检查。请以 CI（.github/workflows/lean.yml）回执为准。
  ------------------------------------------------------------------
-/
import Init

namespace Collatz

/-- 经典一步映射 T。约定 T 0 = 0，仅用于把全函数性补齐。 -/
def T (n : Nat) : Nat :=
  if n % 2 = 0 then n / 2 else 3 * n + 1

/-- `v2 n` = n 中因子 2 的个数。约定 `v2 0 = 0`（只为全函数）。 -/
def v2 : Nat → Nat
  | 0 => 0
  | k + 1 => if (k + 1) % 2 = 0 then v2 ((k + 1) / 2) + 1 else 0
termination_by k => k
decreasing_by
  simp_wf
  exact Nat.div_lt_self (Nat.succ_pos _) (by decide)

/-- 奇数上的压缩映射：C n = (3n+1) / 2^(v2 (3n+1))。 -/
def C (n : Nat) : Nat :=
  (3 * n + 1) / 2 ^ v2 (3 * n + 1)

/-- `Odd n` 的本地写法，避免依赖 Mathlib。 -/
def IsOdd (n : Nat) : Prop := n % 2 = 1

/-- 奇数分解：n + 1 = 2^s * m，m 为奇数。 -/
def Decomp (n s m : Nat) : Prop := n + 1 = 2 ^ s * m ∧ IsOdd m

/-! ### 基础引理 -/

/-- v2 的首步展开。 -/
theorem v2_succ (k : Nat) :
    v2 (k + 1) = if (k + 1) % 2 = 0 then v2 ((k + 1) / 2) + 1 else 0 := by
  rw [v2]

/-- 乘 2 使 v2 加一（对非零数成立）。 -/
theorem v2_two_mul_succ (u : Nat) : v2 (2 * (u + 1)) = v2 (u + 1) + 1 := by
  have h : 2 * (u + 1) = 2 * u + 1 + 1 := by omega
  rw [h, v2_succ]
  have hmod : (2 * u + 1 + 1) % 2 = 0 := by omega
  rw [if_pos hmod]
  have hdiv : (2 * u + 1 + 1) / 2 = u + 1 := by omega
  rw [hdiv]

/-- 奇数上 v2 为 0。 -/
theorem v2_odd {n : Nat} (h : IsOdd n) : v2 n = 0 := by
  cases n with
  | zero =>
      unfold IsOdd at h
      exact absurd h (by decide)
  | succ k =>
      show v2 (k + 1) = 0
      rw [v2_succ]
      split
      · unfold IsOdd at h
        omega
      · rfl

/-- 形如 2 × 奇数的数，v2 恰为 1。 -/
theorem v2_two_mul_odd (k : Nat) : v2 (2 * (2 * k + 1)) = 1 := by
  have h := v2_two_mul_succ (2 * k)
  have hodd : IsOdd (2 * k + 1) := by
    unfold IsOdd
    omega
  rw [h, v2_odd hodd]
  omega

end Collatz
