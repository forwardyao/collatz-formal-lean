# lean-build 回执（自动回写）

- commit: c9dfcca90ef99a54c758c67f545b6086fc5c021e
- run_id: 44490338337

## 版本锚点
~~~
Lake version 5.0.0-src+eb6cafb (Lean version 4.35.0)
Lean (version 4.35.0, x86_64-unknown-linux-gnu, commit eb6cafb7290e8bd5f2937522d8d804f58f02bafc, Release)
~~~
## 退出码（0 为通过）
~~~
exit=1
exit=0
~~~
## olean 产物清单
~~~
.lake/build/lib/lean/Collatz/Basic.olean
.lake/build/lib/lean/Collatz/RiseRun.olean
~~~
## build.log 中的 error 行（最多 30 条）
~~~
7:error: Collatz/Q4S2.lean:41:32: omega could not prove the goal:
15:error: Collatz/Q4S2.lean:90:3: unknown tactic
16:error: Collatz/Q4S2.lean:72:32: omega could not prove the goal:
24:error: Collatz/Q4S2.lean:87:42: Type mismatch
30:error: Collatz/Q4S2.lean:64:44: unsolved goals
45:error: build failed
~~~
## build.log 尾部 40 行
~~~
trace: .> LEAN_PATH=/home/runner/work/collatz-formal-lean/collatz-formal-lean/.lake/build/lib/lean /home/runner/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean /home/runner/work/collatz-formal-lean/collatz-formal-lean/Collatz/Q4S2.lean -o /home/runner/work/collatz-formal-lean/collatz-formal-lean/.lake/build/lib/lean/Collatz/Q4S2.olean -i /home/runner/work/collatz-formal-lean/collatz-formal-lean/.lake/build/lib/lean/Collatz/Q4S2.ilean -c /home/runner/work/collatz-formal-lean/collatz-formal-lean/.lake/build/ir/Collatz/Q4S2.c --setup /home/runner/work/collatz-formal-lean/collatz-formal-lean/.lake/build/ir/Collatz/Q4S2.setup.json --json
error: Collatz/Q4S2.lean:41:32: omega could not prove the goal:
a possible counterexample may satisfy the constraints
  b ≥ 0
  a ≥ 0
  4*a - b ≥ -2
where
 a := ↑k
 b := ↑m
error: Collatz/Q4S2.lean:90:3: unknown tactic
error: Collatz/Q4S2.lean:72:32: omega could not prove the goal:
a possible counterexample may satisfy the constraints
  b ≥ 0
  a ≥ 0
  4*a - b ≥ 0
where
 a := ↑k
 b := ↑m
error: Collatz/Q4S2.lean:87:42: Type mismatch
  Nat.one_le_pow (v2 (9 * k + 2)) 2
has type
  0 < 2 → 1 ≤ 2 ^ v2 (9 * k + 2)
but is expected to have type
  1 ≤ 2 ^ v2 (9 * k + 2)
error: Collatz/Q4S2.lean:64:44: unsolved goals
n m : Nat
hd : Decomp n 2 m
h16 : n % 16 = 3
k : Nat
hnk : n = 16 * k + 3
hm : m = 4 * k + 1
he : 9 * m - 1 = 4 * (9 * k + 2)
hpos : 0 < 9 * k + 2
hv : v2 (9 * m - 1) = v2 (9 * k + 2) + 2
hvge : 2 ≤ v2 (9 * m - 1)
hd4 : 4 ≤ 2 ^ v2 (9 * m - 1)
⊢ (9 * m - 1) / 2 ^ v2 (9 * m - 1) < n
Some required targets logged failures:
- Collatz.Q4S2
error: build failed
~~~
## test.log 中的 error 行（最多 30 条）
~~~
~~~
## test.log 尾部 60 行
~~~
"H1 ok: 20000 odds, no counterexample"
"H2 ok: 20000 odds, no counterexample"
"H3 ok: 3000 odds x all rise steps"
[(1, 0, 1),
 (2, 1, 5),
 (3, 2, 17),
 (4, 3, 53),
 (5, 4, 161),
 (6, 5, 485),
 (7, 6, 1457),
 (8, 7, 4373),
 (9, 8, 13121),
 (10, 9, 39365),
 (11, 10, 118097),
 (12, 11, 354293)]
~~~
## sorry 清单（应 7 处）
~~~
~~~
