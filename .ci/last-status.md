# lean-build 回执（自动回写）

- commit: b6470743e1316dceaa51b791de0a588078e6e768
- run_id: 43426323034

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
10:error: Collatz/RiseRun.lean:27:4: No goals to be solved
19:error: build failed
~~~
## build.log 尾部 40 行
~~~
info: collatz: no previous manifest, creating one from scratch
info: toolchain not updated; already up-to-date
⚠ [2/5] Built Collatz.Basic (387ms)
warning: Collatz/Basic.lean:47:6: `if_pos` has been deprecated: Use `ite_eq_left` instead

Hint: Replace the deprecated name:
  i̵f̵_̵p̵o̵s̵i̲t̲e̲_̲e̲q̲_̲l̲e̲f̲t̲
✖ [3/5] Building Collatz.RiseRun (325ms)
trace: .> LEAN_PATH=/home/runner/work/collatz-formal-lean/collatz-formal-lean/.lake/build/lib/lean /home/runner/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean /home/runner/work/collatz-formal-lean/collatz-formal-lean/Collatz/RiseRun.lean -o /home/runner/work/collatz-formal-lean/collatz-formal-lean/.lake/build/lib/lean/Collatz/RiseRun.olean -i /home/runner/work/collatz-formal-lean/collatz-formal-lean/.lake/build/lib/lean/Collatz/RiseRun.ilean -c /home/runner/work/collatz-formal-lean/collatz-formal-lean/.lake/build/ir/Collatz/RiseRun.c --setup /home/runner/work/collatz-formal-lean/collatz-formal-lean/.lake/build/ir/Collatz/RiseRun.setup.json --json
error: Collatz/RiseRun.lean:27:4: No goals to be solved
warning: Collatz/RiseRun.lean:32:8: declaration uses `sorry`
warning: Collatz/RiseRun.lean:51:8: declaration uses `sorry`
warning: Collatz/RiseRun.lean:59:8: declaration uses `sorry`
warning: Collatz/RiseRun.lean:67:8: declaration uses `sorry`
warning: Collatz/RiseRun.lean:73:8: declaration uses `sorry`
warning: Collatz/RiseRun.lean:80:8: declaration uses `sorry`
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
Collatz/RiseRun.lean:34:  sorry
Collatz/RiseRun.lean:53:  sorry
Collatz/RiseRun.lean:62:  sorry
Collatz/RiseRun.lean:70:  sorry
Collatz/RiseRun.lean:75:  sorry
Collatz/RiseRun.lean:82:  sorry
~~~
