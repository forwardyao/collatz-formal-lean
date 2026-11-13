# lean-build 回执（自动回写）

- commit: b52c5f89abdc3e0c5fbed1b206ba0eff5ea95316
- run_id: 43407578446

## 版本锚点
```
Lake version 5.0.0-src+eb6cafb (Lean version 4.35.0)
Lean (version 4.35.0, x86_64-unknown-linux-gnu, commit eb6cafb7290e8bd5f2937522d8d804f58f02bafc, Release)
```
## 退出码
```
exit=0
exit=1
```
## build.log 中的 error 行（最多 40 条）
```
```
## build.log 尾部 60 行
```
info: collatz: no previous manifest, creating one from scratch
info: toolchain not updated; already up-to-date
⚠ [2/5] Built Collatz.Basic (326ms)
warning: Collatz/Basic.lean:47:6: `if_pos` has been deprecated: Use `ite_eq_left` instead

Hint: Replace the deprecated name:
  i̵f̵_̵p̵o̵s̵i̲t̲e̲_̲e̲q̲_̲l̲e̲f̲t̲
⚠ [3/5] Built Collatz.RiseRun (253ms)
warning: Collatz/RiseRun.lean:17:8: declaration uses `sorry`
warning: Collatz/RiseRun.lean:22:8: declaration uses `sorry`
warning: Collatz/RiseRun.lean:41:8: declaration uses `sorry`
warning: Collatz/RiseRun.lean:49:8: declaration uses `sorry`
warning: Collatz/RiseRun.lean:57:8: declaration uses `sorry`
warning: Collatz/RiseRun.lean:63:8: declaration uses `sorry`
warning: Collatz/RiseRun.lean:70:8: declaration uses `sorry`
✔ [4/5] Built Collatz (208ms)
Build completed successfully (5 jobs).
```
## test.log 尾部 30 行
```
  String

Note: Expected a function because this term is being applied to the argument
  5
Collatz/Test.lean:52:72: error: Function expected at
  toString fun n => List.take n badH2
but this term has type
  String

Note: Expected a function because this term is being applied to the argument
  5
Collatz/Test.lean:53:69: error: Function expected at
  toString fun n => List.take n badH3
but this term has type
  String

Note: Expected a function because this term is being applied to the argument
  5
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
```
## sorry 清单（应 7 处）
```
Collatz/RiseRun.lean:19:  sorry
Collatz/RiseRun.lean:24:  sorry
Collatz/RiseRun.lean:43:  sorry
Collatz/RiseRun.lean:52:  sorry
Collatz/RiseRun.lean:60:  sorry
Collatz/RiseRun.lean:65:  sorry
Collatz/RiseRun.lean:72:  sorry
```
