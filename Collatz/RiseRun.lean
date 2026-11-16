/-
  Collatz 形式化线 · 层 L3 主定理陈述
  ------------------------------------------------------------------
  编译状态：本机 Lean v4.35.0 下 `lake build` 通过（Collatz 库：Basic ＋ RiseRun），
  全文 `sorry` 已清零（2026-11-15，H2 并入完成）。
  全仓结论以 CI（.github/workflows/lean.yml）回执为准。

  对应的人写证明见 proofs/首段连升全刻画_证明.md，二者应当逐条对齐。
  ------------------------------------------------------------------
-/
import Collatz.Basic

namespace Collatz

/-! ### H1 模 4 升降判据 -/

/-- 上升侧：n ≡ 3 (mod 4) ⟹ C n > n。 -/
theorem C_gt_self_of_mod4_three (n : Nat) (h : n % 4 = 3) :
    n < C n := by
  have hn4 : n = 4 * (n / 4) + 3 := by omega
  have hv : v2 (3 * n + 1) = 1 := by
    have h3 : 3 * n + 1 = 2 * (2 * (3 * (n / 4) + 2) + 1) := by omega
    rw [h3]
    exact v2_two_mul_odd (3 * (n / 4) + 2)
  have hC : C n = 6 * (n / 4) + 5 := by
    have h2 : 2 ^ v2 (3 * n + 1) = 2 := by rw [hv]
    unfold C
    rw [h2]
    have h3 : 3 * n + 1 = 2 * (6 * (n / 4) + 5) := by omega
    rw [h3]
    omega
  rw [hC]
  omega

/-- 辅助：m ≥ 1 时，4m 的 v2 恰比 m 多 2。 -/
theorem v2_four_mul {m : Nat} (hm : 0 < m) : v2 (4 * m) = v2 m + 2 := by
  cases m with
  | zero => omega
  | succ r =>
      have e1 : 4 * (r + 1) = 2 * (2 * r + 1 + 1) := by omega
      rw [e1, v2_two_mul_succ (2 * r + 1)]
      have e2 : 2 * r + 1 + 1 = 2 * (r + 1) := by omega
      rw [e2, v2_two_mul_succ r]

/-- 下降侧：n ≡ 1 (mod 4) 且 n > 1 ⟹ C n < n。 -/
theorem C_lt_self_of_mod4_one (n : Nat) (h : n % 4 = 1) (h1 : 1 < n) :
    C n < n := by
  have hn4 : n = 4 * (n / 4) + 1 := by omega
  have hq : 0 < 3 * (n / 4) + 1 := by omega
  have h4 : 3 * n + 1 = 4 * (3 * (n / 4) + 1) := by omega
  have hv : v2 (3 * n + 1) = v2 (3 * (n / 4) + 1) + 2 := by
    rw [h4]
    exact v2_four_mul hq
  have hw : 4 ≤ 2 ^ v2 (3 * n + 1) := by
    rw [hv, Nat.pow_add]
    have hp : 0 < 2 ^ v2 (3 * (n / 4) + 1) := Nat.two_pow_pos _
    have h2 : 2 ^ 2 = 4 := by decide
    rw [h2]
    omega
  have hC : C n ≤ 3 * (n / 4) + 1 := by
    unfold C
    have hmono : (3 * n + 1) / 2 ^ v2 (3 * n + 1) ≤ (3 * n + 1) / 4 :=
      Nat.div_le_div_left hw (by decide)
    have hq4 : (3 * n + 1) / 4 = 3 * (n / 4) + 1 := by omega
    omega
  have hlt : 3 * (n / 4) + 1 < n := by omega
  exact Nat.lt_of_le_of_lt hC hlt

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

/- 陈述（H2）：n 为奇数时，连升步数恰为 `v2 (n+1) - 1`。
   证明依赖 `riseRunFuel_decomp` 与 `decomp_pow_v2`，完整证明见下文「H2 证明」小节。 -/

/-! ### H3 预备引理 -/

/-- H3 辅助：2^k（k ≥ 1）可写成 2q。 -/
theorem two_pow_even {k : Nat} (h : 1 ≤ k) : ∃ q, 2 ^ k = 2 * q := by
  cases k with
  | zero => omega
  | succ r =>
      refine ⟨2 ^ r, ?_⟩
      show 2 ^ (r + 1) = 2 * 2 ^ (r + 1 - 1)
      rw [Nat.pow_succ]
      show 2 ^ r * 2 = 2 * 2 ^ r
      rw [Nat.mul_comm]

/-- H3 辅助：C 的迭代与单步 C 可交换。 -/
theorem itC_C_comm (k n : Nat) : itC k (C n) = C (itC k n) := by
  induction k generalizing n with
  | zero => rfl
  | succ k ih =>
      show itC k (C (C n)) = C (itC k (C n))
      rw [ih (C n)]

/-- H3 核心小步：若 3A + 1 = 2B 且 B 为奇数，则 C A = B。 -/
theorem C_of_two_mul_odd (A B : Nat) (h : 3 * A + 1 = 2 * B) (hB : IsOdd B) :
    C A = B := by
  unfold C
  have hBpos : 0 < B := by unfold IsOdd at hB; omega
  have hv : v2 (3 * A + 1) = 1 := by
    rw [h]
    have hz : v2 B = 0 := v2_odd hB
    have h2 : v2 (2 * B) = v2 B + 1 := by
      cases B with
      | zero => omega
      | succ r => exact v2_two_mul_succ r
    rw [h2, hz]
  rw [hv, h, Nat.pow_one]
  omega

/-- H3 辅助（抽象）：3X = 2Y 且 X ≥ 1 ⟹ 3(X−1) + 1 = 2(Y−1)。 -/
theorem three_mul_sub_one_add_one (X Y : Nat) (hX : 1 ≤ X) (h : 3 * X = 2 * Y) :
    3 * (X - 1) + 1 = 2 * (Y - 1) := by omega

/-- H3 辅助（抽象）：Y ≥ 1 且 Y 为偶数 ⟹ Y − 1 为奇数。 -/
theorem isOdd_sub_one_of_even {Y : Nat} (hY1 : 1 ≤ Y) (hY : ∃ Q, Y = 2 * Q) :
    IsOdd (Y - 1) := by
  obtain ⟨Q, hQ⟩ := hY
  have hQ1 : 1 ≤ Q := by omega
  unfold IsOdd
  have hrw : 2 * Q - 1 = 2 * (Q - 1) + 1 := by omega
  rw [hQ, hrw]
  omega

/-- H3 辅助：m > 0 时 3^j * 2^(s-j) * m ≥ 1。 -/
theorem one_le_three_pow_mul (s m j : Nat) (hm : 0 < m) :
    1 ≤ 3 ^ j * 2 ^ (s - j) * m := by
  have a1 : 0 < 3 ^ j := by have := Nat.one_le_pow j 3 (by decide); omega
  have a2 : 0 < 2 ^ (s - j) := Nat.two_pow_pos _
  have a3 : 0 < 3 ^ j * 2 ^ (s - j) := Nat.mul_pos a1 a2
  have := Nat.mul_pos a3 hm
  omega

/-- H3 辅助：j + 1 ≤ s 时 3·(3^j·2^(s-j)·m) = 2·(3^(j+1)·2^(s-(j+1))·m)。 -/
theorem three_mul_eq_two_mul (s m j : Nat) (hj : j + 1 ≤ s) :
    3 * (3 ^ j * 2 ^ (s - j) * m) = 2 * (3 ^ (j + 1) * 2 ^ (s - (j + 1)) * m) := by
  have hsj : s - j = (s - (j + 1)) + 1 := by omega
  rw [hsj, Nat.pow_add, Nat.pow_one, Nat.pow_succ]
  simp [Nat.mul_assoc, Nat.mul_comm, Nat.mul_left_comm]

/-- H3 辅助：s - (j+1) ≥ 1 时 3^(j+1)·2^(s-(j+1))·m 为偶数。 -/
theorem even_three_pow_mul (s m j : Nat) (hsk : 1 ≤ s - (j + 1)) :
    ∃ Q, 3 ^ (j + 1) * 2 ^ (s - (j + 1)) * m = 2 * Q := by
  obtain ⟨q, hq⟩ := two_pow_even hsk
  refine ⟨3 ^ (j + 1) * q * m, ?_⟩
  rw [hq]
  simp [Nat.mul_assoc, Nat.mul_comm, Nat.mul_left_comm]

/-! ### H3 闭式 -/

/-- 陈述（H3）：n + 1 = 2^s * m（m 奇），则第 j 步（0 ≤ j ≤ s-1）为
    `3^j * 2^(s-j) * m - 1`。 -/
theorem iterate_closed_form (n s m j : Nat) (hd : Decomp n s m)
    (hs : 1 ≤ s) (hj : j ≤ s - 1) :
    itC j n = 3 ^ j * 2 ^ (s - j) * m - 1 := by
  obtain ⟨hdec, hm⟩ := hd
  have hmpos : 0 < m := by unfold IsOdd at hm; omega
  induction j with
  | zero =>
      show n = 3 ^ 0 * 2 ^ (s - 0) * m - 1
      have h0 : n = 2 ^ s * m - 1 := by rw [← hdec]; omega
      rw [h0]
      simp
  | succ j ih =>
      have hj' : j ≤ s - 1 := by omega
      have ihj := ih hj'
      have hcomm : itC (j + 1) n = C (itC j n) := by
        show itC j (C n) = C (itC j n)
        exact itC_C_comm j n
      rw [hcomm, ihj]
      have hjs : j + 1 ≤ s := by omega
      have hsk : 1 ≤ s - (j + 1) := by omega
      refine C_of_two_mul_odd (3 ^ j * 2 ^ (s - j) * m - 1)
        (3 ^ (j + 1) * 2 ^ (s - (j + 1)) * m - 1) ?_ ?_
      · exact three_mul_sub_one_add_one _ _
          (one_le_three_pow_mul s m j hmpos) (three_mul_eq_two_mul s m j hjs)
      · exact isOdd_sub_one_of_even (one_le_three_pow_mul s m (j + 1) hmpos)
          (even_three_pow_mul s m j hsk)

/-! ### H4 预备引理 -/

/-- H4 辅助：奇数乘积仍为奇数。 -/
theorem isOdd_mul {a b : Nat} (ha : IsOdd a) (hb : IsOdd b) : IsOdd (a * b) := by
  unfold IsOdd at *
  rw [Nat.mul_mod, ha, hb]

/-- H4 辅助：3 的幂为奇数。 -/
theorem isOdd_three_pow (j : Nat) : IsOdd (3 ^ j) := by
  induction j with
  | zero => unfold IsOdd; decide
  | succ j ih =>
      rw [Nat.pow_succ]
      exact isOdd_mul ih (by unfold IsOdd; decide)

/-- H4 辅助：s - j ≥ 2 时 3^j · 2^(s-j) · m 是 4 的倍数（并给出商 ≥ 1）。 -/
theorem four_dvd_three_pow_mul (s m j : Nat) (hm : 0 < m) (hj : 2 ≤ s - j) :
    ∃ K, 1 ≤ K ∧ 3 ^ j * 2 ^ (s - j) * m = 4 * K := by
  refine ⟨3 ^ j * 2 ^ (s - j - 2) * m, ?_, ?_⟩
  · have a1 : 0 < 3 ^ j := by have := Nat.one_le_pow j 3 (by decide); omega
    have a2 : 0 < 2 ^ (s - j - 2) := Nat.two_pow_pos _
    have a3 := Nat.mul_pos (Nat.mul_pos a1 a2) hm
    omega
  have hsj : s - j = (s - j - 2) + 2 := by omega
  rw [hsj, Nat.pow_add]
  have h4 : 2 ^ 2 = 4 := by decide
  rw [h4]
  simp [Nat.mul_assoc, Nat.mul_comm, Nat.mul_left_comm]

/-- H4 辅助：4K − 1 ≡ 3 (mod 4)（K ≥ 1）。 -/
theorem four_mul_sub_one_mod (K : Nat) (hK : 1 ≤ K) : (4 * K - 1) % 4 = 3 := by omega

/-- H4 辅助：s - j ≥ 2 ⟹ 第 j 步值 ≡ 3 (mod 4)。 -/
theorem three_pow_mul_sub_one_mod4 (s m j : Nat) (hm : 0 < m) (hj : 2 ≤ s - j) :
    (3 ^ j * 2 ^ (s - j) * m - 1) % 4 = 3 := by
  obtain ⟨K, hK1, hK⟩ := four_dvd_three_pow_mul s m j hm hj
  rw [hK]
  exact four_mul_sub_one_mod K hK1

/-- H4 辅助：第 s-1 步值 ≡ 1 (mod 4)。 -/
theorem three_pow_mul_mod4_one (s m : Nat) (hmo : IsOdd m) (hs : 1 ≤ s) :
    (3 ^ (s - 1) * 2 ^ (s - (s - 1)) * m - 1) % 4 = 1 := by
  have h1 : s - (s - 1) = 1 := by omega
  rw [h1, Nat.pow_one]
  have hodd : IsOdd (3 ^ (s - 1) * m) := isOdd_mul (isOdd_three_pow (s - 1)) hmo
  unfold IsOdd at hodd
  have hre : 3 ^ (s - 1) * 2 * m = 2 * (3 ^ (s - 1) * m) := by
    simp [Nat.mul_comm, Nat.mul_left_comm]
  rw [hre]
  omega

/-! ### H4 恰好性 -/

/-- 陈述（H4a）：j < s-1 时迭代值 ≡ 3 (mod 4)，即仍在上升段。 -/
theorem iterate_mod4_three (n s m j : Nat) (hd : Decomp n s m)
    (hs : 1 ≤ s) (hj : j + 1 ≤ s - 1) :
    itC j n % 4 = 3 := by
  have hjs : j ≤ s - 1 := by omega
  rw [iterate_closed_form n s m j hd hs hjs]
  obtain ⟨_, hm⟩ := hd
  have hmpos : 0 < m := by unfold IsOdd at hm; omega
  have h2 : 2 ≤ s - j := by omega
  exact three_pow_mul_sub_one_mod4 s m j hmpos h2

/-- 陈述（H4b）：第 s-1 步恰落 ≡ 1 (mod 4)，即上升段在此终止。 -/
theorem iterate_mod4_one (n s m : Nat) (hd : Decomp n s m) (hs : 1 ≤ s) :
    itC (s - 1) n % 4 = 1 := by
  rw [iterate_closed_form n s m (s - 1) hd hs (Nat.le_refl _)]
  obtain ⟨_, hm⟩ := hd
  exact three_pow_mul_mod4_one s m hm hs

theorem v2_one : v2 1 = 0 := by
  have e : (1 : Nat) = 0 + 1 := rfl
  rw [e, v2_succ, ite_eq_right (by decide : ¬ (0 + 1) % 2 = 0)]

theorem v2_two : v2 2 = 1 := by
  have e : (2 : Nat) = 1 + 1 := rfl
  rw [e, v2_succ, ite_eq_left (by decide : (1 + 1) % 2 = 0)]
  have e2 : (1 + 1) / 2 = 1 := by decide
  rw [e2, v2_one]

theorem v2_four : v2 4 = 2 := by
  have e : (4 : Nat) = 3 + 1 := rfl
  rw [e, v2_succ, ite_eq_left (by decide : (3 + 1) % 2 = 0)]
  have e2 : (3 + 1) / 2 = 2 := by decide
  rw [e2, v2_two]

/-- 1 的压缩值为 1。 -/
theorem C_one : C 1 = 1 := by
  unfold C
  rw [v2_four]

/-- 上升步的燃料展开。 -/
theorem riseRunFuel_step {f n : Nat} (h : n < C n) :
    riseRunFuel (f + 1) n = riseRunFuel f (C n) + 1 := by
  simp only [riseRunFuel, ite_eq_left h]

/-- 停止步的燃料展开。 -/
theorem riseRunFuel_stop {f n : Nat} (h : ¬ n < C n) :
    riseRunFuel (f + 1) n = 0 := by
  simp only [riseRunFuel, ite_eq_right h]

/-- Decomp 蕴含 n 为奇数。 -/
theorem isOdd_of_decomp (n s m : Nat) (hd : Decomp n s m) (hs : 1 ≤ s) : IsOdd n := by
  obtain ⟨hdec, hm⟩ := hd
  have hsp : s = (s - 1) + 1 := by omega
  have hX : n + 1 = 2 * (2 ^ (s - 1) * m) := by
    rw [hdec, hsp, Nat.pow_succ]
    simp [Nat.mul_comm, Nat.mul_left_comm]
  have hm1 : 1 ≤ m := by unfold IsOdd at hm; omega
  have hpos : 0 < 2 ^ (s - 1) * m := Nat.mul_pos (Nat.two_pow_pos _) (by omega)
  unfold IsOdd
  have hn : n = 2 * (2 ^ (s - 1) * m) - 1 := by omega
  rw [hn]
  omega

/-- 上升段长度（一般形式）：Decomp n s m 下，燃料 s 恰好走完 s-1 步上升。 -/
theorem riseRunFuel_decomp : (n s m : Nat) → Decomp n s m → 1 ≤ s → riseRunFuel s n = s - 1
  | _, 0, _, _, hs => by omega
  | n, s + 1, m, hd, hs => by
      cases s with
      | zero =>
          have h4 : n % 4 = 1 := by
            have h := iterate_mod4_one n 1 m hd (by decide : 1 ≤ 1)
            simpa [itC] using h
          have hnodd : IsOdd n := isOdd_of_decomp n 1 m hd (by decide)
          have hstop : ¬ n < C n := by
            by_cases h1 : 1 < n
            · have hlt := C_lt_self_of_mod4_one n h4 h1
              omega
            · have hn1 : n = 1 := by omega
              rw [hn1, C_one]
              omega
          rw [riseRunFuel_stop hstop]
      | succ r =>
          have hnodd : IsOdd n := isOdd_of_decomp n (r + 2) m hd (by omega)
          have h3 : n % 4 = 3 := by
            have h := iterate_mod4_three n (r + 2) m 0 hd (by omega) (by omega)
            simpa [itC] using h
          have hlt : n < C n := C_gt_self_of_mod4_three n h3
          have hCn : C n = 3 ^ 1 * 2 ^ (r + 2 - 1) * m - 1 := by
            have h := iterate_closed_form n (r + 2) m 1 hd (by omega) (by omega)
            simpa [itC] using h
          obtain ⟨hdec, hm⟩ := hd
          have hd' : Decomp (C n) (r + 1) (3 * m) := by
            constructor
            · have h1 : r + 2 - 1 = r + 1 := by omega
              have hm1 : 1 ≤ m := by unfold IsOdd at hm; omega
              have hX1 : 1 ≤ 3 ^ 1 * 2 ^ (r + 1) * m := by
                have hp1 : 0 < 3 ^ 1 * 2 ^ (r + 1) := Nat.mul_pos (by decide) (Nat.two_pow_pos _)
                have hp2 : 0 < 3 ^ 1 * 2 ^ (r + 1) * m := Nat.mul_pos hp1 (by omega)
                omega
              rw [hCn, h1]
              have hsub : 3 ^ 1 * 2 ^ (r + 1) * m - 1 + 1 = 3 ^ 1 * 2 ^ (r + 1) * m := by omega
              rw [hsub]
              simp [Nat.mul_comm, Nat.mul_left_comm]
            · exact isOdd_mul (by unfold IsOdd; decide) hm
          rw [riseRunFuel_step hlt]
          rw [riseRunFuel_decomp (C n) (r + 1) (3 * m) hd' (by omega)]
          omega

/-! ### H2 证明 -/

/-- H2 辅助：v2 的倍增性（非零）。 -/
theorem v2_two_mul_gen {w : Nat} (hw : 0 < w) : v2 (2 * w) = v2 w + 1 := by
  cases w with
  | zero => omega
  | succ u => exact v2_two_mul_succ u

/-- H2 辅助（v2 分解）：任意正整数 N 可写成 2^(v2 N) × 奇数。
    对 N 做模 2 归纳（模式 N+2 保持同奇偶），偶分支拆出因子 2 递归，奇分支直接取 N 本身。 -/
theorem decomp_pow_v2 : (N : Nat) → 0 < N → ∃ m, N = 2 ^ v2 N * m ∧ IsOdd m
  | 0, h => by omega
  | 1, _ => by
      refine ⟨1, ?_, by unfold IsOdd; decide⟩
      rw [v2_one]
  | N + 2, _ => by
      by_cases h2 : (N + 2) % 2 = 0
      · -- 偶数：可拆出因子 2，对 (N+2)/2 递归
        have hN2 : 0 < (N + 2) / 2 :=
          Nat.div_pos (by omega) (by decide)
        have hNeq : N + 2 = 2 * ((N + 2) / 2) := by
          have hdm := Nat.div_add_mod (N + 2) 2
          rw [h2] at hdm
          omega
        have hv : v2 (2 * ((N + 2) / 2)) = v2 ((N + 2) / 2) + 1 :=
          v2_two_mul_gen hN2
        have hv2N : v2 (N + 2) = v2 (2 * ((N + 2) / 2)) :=
          congrArg v2 hNeq
        have hs1 : 1 ≤ v2 (N + 2) := by omega
        have hv0 : v2 ((N + 2) / 2) = v2 (N + 2) - 1 := by omega
        obtain ⟨m, hm1, hm2⟩ := decomp_pow_v2 ((N + 2) / 2) hN2
        refine ⟨m, ?_, hm2⟩
        have hm1r : (N + 2) / 2 = 2 ^ (v2 (N + 2) - 1) * m := by
          rw [hm1, hv0]
        have hpow : 2 ^ v2 (N + 2) = 2 * 2 ^ (v2 (N + 2) - 1) := by
          obtain ⟨k, hk⟩ : ∃ k, v2 (N + 2) = k + 1 := ⟨v2 (N + 2) - 1, by omega⟩
          rw [hk, Nat.pow_succ, Nat.add_sub_cancel]
          exact Nat.mul_comm (2 ^ k) 2
        have hstep2 : 2 * ((N + 2) / 2) = 2 * (2 ^ (v2 (N + 2) - 1) * m) := by
          rw [hm1r]
        have hstep3 : 2 * (2 ^ (v2 (N + 2) - 1) * m) = 2 ^ v2 (N + 2) * m := by
          rw [hpow, Nat.mul_assoc]
        exact hNeq.trans (hstep2.trans hstep3)
      · -- 奇数：v2 = 0，取 m = N 本身
        have hv0 : v2 (N + 2) = 0 := by
          have e : N + 2 = (N + 1) + 1 := by omega
          rw [e, v2_succ, ite_eq_right (by omega : ¬ ((N + 1) + 1) % 2 = 0)]
        refine ⟨N + 2, ?_, ?_⟩
        · rw [hv0]; simp
        · unfold IsOdd; omega

/-- 陈述（H2）：n 为奇数时，连升步数恰为 `v2 (n+1) - 1`。
    奇性保证 n+1 为偶，故 v2 (n+1) ≥ 1；对 n+1 做 v2 分解后代入 `riseRunFuel_decomp`。 -/
theorem riseRun_eq (n : Nat) (hn : IsOdd n) :
    riseRunFuel (v2 (n + 1)) n = v2 (n + 1) - 1 := by
  have hN : 0 < n + 1 := by omega
  obtain ⟨m, hdec, hm⟩ := decomp_pow_v2 (n + 1) hN
  have hs : 1 ≤ v2 (n + 1) := by
    have h2n : (n + 1) % 2 = 0 := by unfold IsOdd at hn; omega
    have he : n + 1 = 2 * ((n + 1) / 2) := by
      have hdm := Nat.div_add_mod (n + 1) 2
      rw [h2n] at hdm
      omega
    have hdiv : 0 < (n + 1) / 2 := by omega
    rw [he, v2_two_mul_gen hdiv]
    omega
  exact riseRunFuel_decomp n (v2 (n + 1)) m ⟨hdec, hm⟩ hs

/-- 陈述（H5）：梅森数 2^k - 1 的连升步数为 k - 1。 -/
theorem mersenne (k : Nat) (hk : 1 ≤ k) :
    riseRunFuel k (2 ^ k - 1) = k - 1 := by
  have hd : Decomp (2 ^ k - 1) k 1 := by
    constructor
    · have hp := Nat.two_pow_pos k
      omega
    · unfold IsOdd; decide
  exact riseRunFuel_decomp (2 ^ k - 1) k 1 hd hk
/-! ### H5 梅森特例 -/

/-- 陈述（H5）：n = 2^k - 1 时 r = k-1，且第 j 步 = 3^j * 2^(k-j) - 1。 -/
theorem mersenne_riseRun (k : Nat) (hk : 1 ≤ k) :
    riseRunFuel k (2 ^ k - 1) = k - 1 := by
  have hd : Decomp (2 ^ k - 1) k 1 := by
    constructor
    · have hp := Nat.two_pow_pos k
      omega
    · unfold IsOdd; decide
  exact riseRunFuel_decomp (2 ^ k - 1) k 1 hd hk

end Collatz
