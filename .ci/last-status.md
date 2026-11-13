# lean-build 回执（自动回写）

- commit: a1d0bec5066d57288c7bfbcfe545c9a34f966775
- run_id: 43422403667

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
~~~
## build.log 中的 error 行（最多 30 条）
~~~
9:error: Collatz/Basic.lean:72:2: No goals to be solved
12:error: build failed
~~~
## build.log 尾部 40 行
~~~
info: collatz: no previous manifest, creating one from scratch
info: toolchain not updated; already up-to-date
✖ [2/5] Building Collatz.Basic (472ms)
trace: .> LEAN_PATH=/home/runner/work/collatz-formal-lean/collatz-formal-lean/.lake/build/lib/lean /home/runner/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean /home/runner/work/collatz-formal-lean/collatz-formal-lean/Collatz/Basic.lean -o /home/runner/work/collatz-formal-lean/collatz-formal-lean/.lake/build/lib/lean/Collatz/Basic.olean -i /home/runner/work/collatz-formal-lean/collatz-formal-lean/.lake/build/lib/lean/Collatz/Basic.ilean -c /home/runner/work/collatz-formal-lean/collatz-formal-lean/.lake/build/ir/Collatz/Basic.c --setup /home/runner/work/collatz-formal-lean/collatz-formal-lean/.lake/build/ir/Collatz/Basic.setup.json --json
warning: Collatz/Basic.lean:47:6: `if_pos` has been deprecated: Use `ite_eq_left` instead

Hint: Replace the deprecated name:
  i̵f̵_̵p̵o̵s̵i̲t̲e̲_̲e̲q̲_̲l̲e̲f̲t̲
error: Collatz/Basic.lean:72:2: No goals to be solved
Some required targets logged failures:
- Collatz.Basic
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
Collatz/RiseRun.lean:19:  sorry
Collatz/RiseRun.lean:24:  sorry
Collatz/RiseRun.lean:43:  sorry
Collatz/RiseRun.lean:52:  sorry
Collatz/RiseRun.lean:60:  sorry
Collatz/RiseRun.lean:65:  sorry
Collatz/RiseRun.lean:72:  sorry
~~~
