import Collatz.Basic
import Collatz.RiseRun

/- 总入口：把各模块串起来，便于 `lake build` 一次性检查。

   注：Lean 4 要求 import 出现在文件最开头。此处把说明放在 import 之后，
   因为 `/-- ... -/` 是文档注释，会被解析器当作“下一个声明的说明”，
   后面紧跟 import 会报 unexpected token 'import'。 -/
