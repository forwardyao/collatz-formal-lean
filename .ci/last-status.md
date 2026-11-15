# lean-build 回执（自动回写）

- commit: 7f0604c0e108f8eb8c85065ada0e27294189ec95
- run_id: 43678198291

## 版本锚点
~~~
Lake version 5.0.0-src+eb6cafb (Lean version 4.35.0)
Lean (version 4.35.0, x86_64-unknown-linux-gnu, commit eb6cafb7290e8bd5f2937522d8d804f58f02bafc, Release)
~~~
## 退出码（0 为通过）
~~~
exit=1
exit=1
~~~
## olean 产物清单
~~~
.lake/build/lib/lean/Collatz/Basic.olean
~~~
## build.log 中的 error 行（最多 30 条）
~~~
10:error: Collatz/RiseRun.lean:25:52: No goals to be solved
19:error: build failed
~~~
## build.log 尾部 40 行
~~~
info: collatz: no previous manifest, creating one from scratch
info: toolchain not updated; already up-to-date
⚠ [2/5] Built Collatz.Basic (364ms)
warning: Collatz/Basic.lean:47:6: `if_pos` has been deprecated: Use `ite_eq_left` instead

Hint: Replace the deprecated name:
  i̵f̵_̵p̵o̵s̵i̲t̲e̲_̲e̲q̲_̲l̲e̲f̲t̲
✖ [3/5] Building Collatz.RiseRun (301ms)
trace: .> LEAN_PATH=/home/runner/work/collatz-formal-lean/collatz-formal-lean/.lake/build/lib/lean /home/runner/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean /home/runner/work/collatz-formal-lean/collatz-formal-lean/Collatz/RiseRun.lean -o /home/runner/work/collatz-formal-lean/collatz-formal-lean/.lake/build/lib/lean/Collatz/RiseRun.olean -i /home/runner/work/collatz-formal-lean/collatz-formal-lean/.lake/build/lib/lean/Collatz/RiseRun.ilean -c /home/runner/work/collatz-formal-lean/collatz-formal-lean/.lake/build/ir/Collatz/RiseRun.c --setup /home/runner/work/collatz-formal-lean/collatz-formal-lean/.lake/build/ir/Collatz/RiseRun.setup.json --json
error: Collatz/RiseRun.lean:25:52: No goals to be solved
warning: Collatz/RiseRun.lean:35:8: declaration uses `sorry`
warning: Collatz/RiseRun.lean:54:8: declaration uses `sorry`
warning: Collatz/RiseRun.lean:62:8: declaration uses `sorry`
warning: Collatz/RiseRun.lean:70:8: declaration uses `sorry`
warning: Collatz/RiseRun.lean:76:8: declaration uses `sorry`
warning: Collatz/RiseRun.lean:83:8: declaration uses `sorry`
Some required targets logged failures:
- Collatz.RiseRun
error: build failed
~~~
## test.log 中的 error 行（最多 30 条）
~~~
1:Collatz/Test.lean:12:0: error: object file '/home/runner/work/collatz-formal-lean/collatz-formal-lean/.lake/build/lib/lean/Collatz/RiseRun.olean' of module Collatz.RiseRun does not exist
~~~
## test.log 尾部 60 行
~~~
Collatz/Test.lean:12:0: error: object file '/home/runner/work/collatz-formal-lean/collatz-formal-lean/.lake/build/lib/lean/Collatz/RiseRun.olean' of module Collatz.RiseRun does not exist
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
