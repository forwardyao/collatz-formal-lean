# lean-build 回执（自动回写）

- commit: 3190ce755677c76ab1bb5204a7b62dbfe54212a8
- run_id: 44497840361

## 版本锚点
~~~
Lake version 5.0.0-src+eb6cafb (Lean version 4.35.0)
Lean (version 4.35.0, x86_64-unknown-linux-gnu, commit eb6cafb7290e8bd5f2937522d8d804f58f02bafc, Release)
~~~
## 退出码（0 为通过）
~~~
exit=0
exit=0
~~~
## olean 产物清单
~~~
.lake/build/lib/lean/Collatz.olean
.lake/build/lib/lean/Collatz/Basic.olean
.lake/build/lib/lean/Collatz/Q4S2.olean
.lake/build/lib/lean/Collatz/RiseRun.olean
~~~
## build.log 中的 error 行（最多 30 条）
~~~
~~~
## build.log 尾部 40 行
~~~
info: collatz: no previous manifest, creating one from scratch
info: toolchain not updated; already up-to-date
✔ [2/6] Built Collatz.Basic (349ms)
✔ [3/6] Built Collatz.RiseRun (1.6s)
✔ [4/6] Built Collatz.Q4S2 (482ms)
✔ [5/6] Built Collatz (185ms)
Build completed successfully (6 jobs).
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
