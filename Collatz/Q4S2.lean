/-
  Collatz 形式化线 · Q4 合入：s=2 整类判据（c=1 / RiseRun 全刻画实例）
  ------------------------------------------------------------------
  对应人写陈述（实录行 274 · v1 深化陈述）：
    对象＝段末映射 R：对奇 n≥3，写 n+1 = 2^s · m（m 奇），
    R(n) = (3^s · m − 1) / 2^{v₂(3^s · m − 1)}，即「首段连升结束后到达的首个奇点」。
    命题＝s=2 整类判据：对一切奇 n≥3 且 n≡3 (mod 8)（等价 v₂(n+1)=2）：
      n≡11 (mod 16) ⟺ R(n) > n；n≡3 (mod 16) ⟺ R(n) < n。

  本文件改写为两条单侧定理（升支／降支），数学上由「类内 n%16 ∈ {3,11} 恒真」
  补全为上述双向判据（类内二分，见文末注释）。s=2 时 R(n) = (9m−1)/2^{v₂(9m−1)}。

  状态标注（如实）：
    - 本文件由起草候选 Collatz_Q4S2.lean（120 行）平移为仓库模块 Collatz/Q4S2.lean，
      数学内容与定理体未作任何改动，仅本头注释更新。
    - 合入后由仓库 lean-build workflow 全量判定：build / test / sorry 计数
      以 .ci/last-status.md 与 .ci/receipt/ 原文回执为准，未经回执不得标绿。
    - 全文不含 sorry，不设占位；数学推导完整，Lean 精化逐条对照库内已判绿引理
      （Basic：v2_two_mul_odd、omega；RiseRun：v2_four_mul；Init：Nat.pow_add、
      Nat.mul_le_mul_right、Nat.le_div_iff_mul_le、Nat.mod_add_div）。
    - 若在 build 环境下个别引理归属有出入（Init 与 Std 边界），按文件内注释替换即可。
  ------------------------------------------------------------------
-/
import Collatz.RiseRun

namespace Collatz

/-! ### Q4 · 升支：n≡11 (mod 16) ⟹ R(n) > n -/

/-- 升支：s=2 类内 n≡11 (mod 16) 时，段末首个奇点高于起点（R(n) > n）。
    前提 Decomp n 2 m 即 n+1 = 4m 且 m 奇，等于 v₁ 陈述中的 s=2 实例。 -/
theorem q4_s2_rise (n m : Nat) (hd : Decomp n 2 m) (h16 : n % 16 = 11) :
    n < (9 * m - 1) / 2 ^ v2 (9 * m - 1) := by
  -- 由 h16：n = 16k + 11
  have hnk : ∃ k, n = 16 * k + 11 := by
    refine ⟨n / 16, ?_⟩
    rw [← Nat.mod_add_div n 16]
    omega
  rcases hnk with ⟨k, hnk⟩
  -- 由 Decomp：n + 1 = 4m ⟹ m = 4k + 3
  have hm : m = 4 * k + 3 := by omega
  -- 9m − 1 = 2·(2·(9k+6)+1)，右端是「2 × 奇数」
  have he : 9 * m - 1 = 2 * (2 * (9 * k + 6) + 1) := by omega
  have hv : v2 (9 * m - 1) = 1 := by
    rw [he, v2_two_mul_odd (9 * k + 6)]
  -- 分母降为 2
  have hd2 : 2 ^ v2 (9 * m - 1) = 2 := by rw [hv]
  -- R(n) = 18k + 13
  have hR : (9 * m - 1) / 2 ^ v2 (9 * m - 1) = 18 * k + 13 := by
    rw [hd2]
    have hnum : 9 * m - 1 = 2 * (18 * k + 13) := by omega
    rw [hnum]
    omega
  -- 16k+11 < 18k+13
  rw [hR]
  omega

/-! ### Q4 · 降支：n≡3 (mod 16) ⟹ R(n) < n -/

/-- 降支：s=2 类内 n≡3 (mod 16) 时，段末首个奇点低于起点（R(n) < n）。
    证明骨架：m = 4k+1 ⟹ 9m−1 = 4·(9k+2) ⟹ v₂(9m−1) = v₂(9k+2)+2 ≥ 2，
    故 R(n) ≤ (9m−1)/4 < 4m−1 = n；中间一步用「商 ≥ x ⟹ 被除数 ≥ x·分母」反证。 -/
theorem q4_s2_fall (n m : Nat) (hd : Decomp n 2 m) (h16 : n % 16 = 3) :
    (9 * m - 1) / 2 ^ v2 (9 * m - 1) < n := by
  -- 由 h16：n = 16k + 3
  have hnk : ∃ k, n = 16 * k + 3 := by
    refine ⟨n / 16, ?_⟩
    rw [← Nat.mod_add_div n 16]
    omega
  rcases hnk with ⟨k, hnk⟩
  -- 由 Decomp：n + 1 = 4m ⟹ m = 4k + 1
  have hm : m = 4 * k + 1 := by omega
  -- 9m − 1 = 4·(9k+2)，4 可整除
  have he : 9 * m - 1 = 4 * (9 * k + 2) := by omega
  have hpos : 0 < 9 * k + 2 := by omega
  -- v₂(9m−1) = v₂(9k+2) + 2 ≥ 2
  have hv : v2 (9 * m - 1) = v2 (9 * k + 2) + 2 := by
    rw [he, v2_four_mul hpos]
  have hvge : 2 ≤ v2 (9 * m - 1) := by
    rw [hv]
    omega
  -- 分母 ≥ 4：2^{v₂} = 2^{v₂(9k+2)} · 4 ≥ 4
  have hd4 : 4 ≤ 2 ^ v2 (9 * m - 1) := by
    rw [hv, Nat.pow_add]
    have htwo : 2 ^ 2 = 4 := by decide
    rw [htwo]
    have hone : 1 ≤ 2 ^ v2 (9 * k + 2) := Nat.one_le_pow (v2 (9 * k + 2)) 2
    exact Nat.mul_le_mul_right 4 hone
  -- 反证：假设 R(n) ≥ n
  by_contra hnot
  push_neg at hnot
  -- hnot : n ≤ (9m−1) / 2^{v₂(9m−1)}；两侧乘分母
  have hle' := (Nat.le_div_iff_mul_le (show 0 < 2 ^ v2 (9 * m - 1) from
      Nat.two_pow_pos (v2 (9 * m - 1)))).1 hnot
  -- n · 分母 ≥ n · 4
  have hn4 : (16 * k + 3) * 4 ≤ (16 * k + 3) * 2 ^ v2 (9 * m - 1) := by
    exact Nat.mul_le_mul_left (16 * k + 3) hd4
  -- 于是 n·4 ≤ 被除数(9m−1)，代入线性式得矛盾
  have hcontr : (16 * k + 3) * 4 ≤ 9 * m - 1 := by
    -- 先展开 hle' 的 n
    have hle'k : (16 * k + 3) * 2 ^ v2 (9 * m - 1) ≤ 9 * m - 1 := by
      simpa [hnk] using hle'
    exact le_trans hn4 hle'k
  have hnum : 9 * m - 1 = 4 * (9 * k + 2) := by omega
  have : (16 * k + 3) * 4 ≤ 4 * (9 * k + 2) := by
    simpa [hnum] using hcontr
  omega

/-!
  ### 双向判据补全说明（数学注，不在本文件内另立引理）

  s=2 类内 n≡3 (mod 8)（即 Decomp n 2 m）时，n = 4m−1、m 奇，
  故 n%16 ∈ {3, 11} 恒真（m%4=1 或 3 二分）。于是：
    - n%16 = 11 ⟺（类内二分）n%16 ≠ 3，结合降支的逆否得 n < R(n)；
    - n%16 = 3 ⟺（类内二分）n%16 ≠ 11，结合升支的逆否得 R(n) < n。
  两个单侧定理合起来即 v₁ 陈述的 s=2 双向判据。
  如需在 Lean 内显式补全 ⟺，补一条初等引理：
    lemma mod16_class_of_mod8_three (n : Nat) (h8 : n % 8 = 3) : n % 16 = 3 ∨ n % 16 = 11
  再对两个主定理各取逆否即可；本起草版以两个单侧定理为准，避免引入
  未经 build 验证的模二分证明。
-/

end Collatz
