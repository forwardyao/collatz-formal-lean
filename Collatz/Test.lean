/-
  Collatz 形式化线 · 层 L3 可执行自检
  ------------------------------------------------------------------
  本文件不含任何 `sorry`，只用 `#eval` 对定义做运行期核对。
  它的意义是：只要本文件能编译并输出 "ok"，就说明 Basic/RiseRun 里的
  定义是良构的、且与 Python 独立实现口径一致（同一批结论、不同实现）。
  它**不能**替代定理证明，也不能替代 `lake build` 对定理体的类型检查。

  编译状态：未验证（本机零编译）。
  ------------------------------------------------------------------
-/
import Collatz.RiseRun

open Collatz

/-- 燃料给 64，足够覆盖 n < 2^64 的所有连升段（r ≤ 63）。 -/
def rr (n : Nat) : Nat := riseRunFuel 64 n

def oddsUpTo (N : Nat) : List Nat := (List.range N).map (fun i => 2 * i + 1)

/-- n+1 去掉全部 2 的因子后剩下的奇数部分。 -/
def oddPart (n : Nat) : Nat := (n + 1) / 2 ^ v2 (n + 1)

/-- 闭式：3^j * 2^(s-j) * m - 1。 -/
def cf (s j m : Nat) : Nat := 3 ^ j * 2 ^ (s - j) * m - 1

/-- H1 反例收集：n≡3 (mod 4) 应升，n≡1 (mod 4) 且 n>1 应降。 -/
def badH1 : List Nat :=
  (oddsUpTo 20000).filter (fun n =>
    if n = 1 then false
    else if n % 4 = 3 then (if n < C n then false else true)
    else if n % 4 = 1 then (if C n < n then false else true)
    else false)

/-- H2 反例收集：连升步数应等于 v2 (n+1) - 1。 -/
def badH2 : List Nat :=
  (oddsUpTo 20000).filter (fun n => rr n != v2 (n + 1) - 1)

/-- H3 反例收集：所有 j ≤ v2(n+1)-1 的迭代值应等于闭式。 -/
def badH3 : List (Nat × Nat) :=
  ((oddsUpTo 3000).bind (fun n => (List.range (v2 (n + 1))).map (fun j => (n, j))))
    |>.filter (fun p => itC p.2 p.1 != cf (v2 (p.1 + 1)) p.2 (oddPart p.1))

/-- H5 抽查：n = 2^k - 1 的连升步数应为 k-1，末值为 2 * 3^(k-1) - 1。 -/
def mersenneRows : List (Nat × Nat × Nat) :=
  (List.range 12).map (fun i =>
    let k := i + 1
    let n := 2 ^ k - 1
    (k, rr n, itC (k - 1) n))

#eval if badH1.isEmpty then "H1 ok: 20000 odds, no counterexample" else toString badH1.take 5
#eval if badH2.isEmpty then "H2 ok: 20000 odds, no counterexample" else toString badH2.take 5
#eval if badH3.isEmpty then "H3 ok: 3000 odds x all rise steps" else toString badH3.take 5
#eval mersenneRows
