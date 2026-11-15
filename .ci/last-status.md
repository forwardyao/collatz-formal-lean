# lean-build 回执（自动回写）

- commit: 8f48f59226528693459542b979e751ea747b3036
- run_id: 43682306798

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
.lake/build/lib/lean/Collatz/RiseRun.olean
~~~
## build.log 中的 error 行（最多 30 条）
~~~
~~~
## build.log 尾部 40 行
~~~
info: collatz: no previous manifest, creating one from scratch
info: toolchain not updated; already up-to-date
⚠ [2/5] Built Collatz.Basic (320ms)
warning: Collatz/Basic.lean:47:6: `if_pos` has been deprecated: Use `ite_eq_left` instead

Hint: Replace the deprecated name:
  i̵f̵_̵p̵o̵s̵i̲t̲e̲_̲e̲q̲_̲l̲e̲f̲t̲
⚠ [3/5] Built Collatz.RiseRun (295ms)
warning: Collatz/RiseRun.lean:17:43: Variable name `hn` is not explicitly referenced.

Hint: The binding can be removed (if unused) or named `_` (if used implicitly). Alternatively, prefix the name with `_` to silence this warning:
  [apply] _hn

Note: This linter can be disabled with `set_option linter.unusedVariables false`
warning: Collatz/RiseRun.lean:35:8: declaration uses `sorry`
warning: Collatz/RiseRun.lean:54:8: declaration uses `sorry`
warning: Collatz/RiseRun.lean:62:8: declaration uses `sorry`
warning: Collatz/RiseRun.lean:70:8: declaration uses `sorry`
warning: Collatz/RiseRun.lean:76:8: declaration uses `sorry`
warning: Collatz/RiseRun.lean:83:8: declaration uses `sorry`
✔ [4/5] Built Collatz (167ms)
Build completed successfully (5 jobs).
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
Collatz/RiseRun.lean:37:  sorry
Collatz/RiseRun.lean:56:  sorry
Collatz/RiseRun.lean:65:  sorry
Collatz/RiseRun.lean:73:  sorry
Collatz/RiseRun.lean:78:  sorry
Collatz/RiseRun.lean:85:  sorry
~~~
