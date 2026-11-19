# lean-build 回执（自动回写）

- commit: ba8bfd6472bd3df3f0b23c272d0a8399a9d481c1
- run_id: 44495845306

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
7:error: Collatz/Q4S2.lean:56:4: No goals to be solved
8:error: Collatz/Q4S2.lean:91:4: No goals to be solved
9:error: Collatz/Q4S2.lean:129:12: Unknown identifier `le_trans`
12:error: build failed
~~~
## build.log 尾部 40 行
~~~
info: collatz: no previous manifest, creating one from scratch
info: toolchain not updated; already up-to-date
✔ [2/6] Built Collatz.Basic (232ms)
✔ [3/6] Built Collatz.RiseRun (908ms)
✖ [4/6] Building Collatz.Q4S2 (297ms)
trace: .> LEAN_PATH=/home/runner/work/collatz-formal-lean/collatz-formal-lean/.lake/build/lib/lean /home/runner/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean /home/runner/work/collatz-formal-lean/collatz-formal-lean/Collatz/Q4S2.lean -o /home/runner/work/collatz-formal-lean/collatz-formal-lean/.lake/build/lib/lean/Collatz/Q4S2.olean -i /home/runner/work/collatz-formal-lean/collatz-formal-lean/.lake/build/lib/lean/Collatz/Q4S2.ilean -c /home/runner/work/collatz-formal-lean/collatz-formal-lean/.lake/build/ir/Collatz/Q4S2.c --setup /home/runner/work/collatz-formal-lean/collatz-formal-lean/.lake/build/ir/Collatz/Q4S2.setup.json --json
error: Collatz/Q4S2.lean:56:4: No goals to be solved
error: Collatz/Q4S2.lean:91:4: No goals to be solved
error: Collatz/Q4S2.lean:129:12: Unknown identifier `le_trans`
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
