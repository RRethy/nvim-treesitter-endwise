; module Foo
((module_def name: (_) @cursor) @endable @indent (#endwise! "end"))

; class Foo / class Foo < Bar
((class_def name: (_) @cursor superclass: (_)? @cursor) @endable @indent (#endwise! "end"))

; struct Foo / struct Foo < Bar
((struct_def name: (_) @cursor superclass: (_)? @cursor) @endable @indent (#endwise! "end"))

; enum Foo
((enum_def name: (_) @cursor) @endable @indent (#endwise! "end"))

; lib Foo
((lib_def name: (_) @cursor) @endable @indent (#endwise! "end"))

; annotation Foo
((annotation_def name: (_) @cursor) @endable @indent (#endwise! "end"))

; def foo / def foo(params) / def foo : Type
; Use method_def itself as cursor to capture all positions including ) and return type
((method_def "def" @indent) @cursor @endable (#endwise! "end"))

; macro foo / macro foo(params)
; Use macro_def itself as cursor
((macro_def "macro" @indent) @cursor @endable (#endwise! "end"))

; fun foo = "name"(params) : ReturnType ... end (top-level fun with body)
((fun_def name: (_) @cursor params: (_)? @cursor body: (_)) @endable @indent (#endwise! "end"))

; struct inside lib
((c_struct_def name: (_) @cursor) @endable @indent (#endwise! "end"))

; union inside lib
((union_def name: (_) @cursor) @endable @indent (#endwise! "end"))

; ===== Control Flow =====

; if condition
((if cond: (_) @cursor) @endable @indent (#endwise! "end"))

; unless condition
((unless cond: (_) @cursor) @endable @indent (#endwise! "end"))

; while condition
((while cond: (_) @cursor) @endable @indent (#endwise! "end"))

; until condition
((until cond: (_) @cursor) @endable @indent (#endwise! "end"))

; case expression (optional condition - covers both regular and exhaustive case)
((case cond: (_)? @cursor) @endable @indent (#endwise! "end"))

; select (channel operations)
((select) @endable @indent (#endwise! "end"))

; ===== Blocks =====

; do ... end blocks (after method calls)
; block is aliased from both do_end_block and brace_block
; Use block itself as cursor to capture all positions including closing |
((block "do" @indent) @cursor @endable (#endwise! "end"))

; begin ... end
((begin "begin" @cursor) @endable @indent (#endwise! "end"))

; ===== ERROR patterns for incomplete syntax =====
; These match during typing before the syntax is complete
; Patterns with child nodes come first (for when parser creates them)
; Fallback patterns use ERROR as cursor (for single-line constructs)

; def foo| - with identifier when parser creates it
((ERROR ("def" @indent . (identifier) @cursor . (param_list)?)) (#endwise! "end"))
; def| - fallback when no identifier parsed
((ERROR ("def" @indent)) @cursor (#endwise! "end"))

; macro foo|
((ERROR ("macro" @indent . (identifier) @cursor . (param_list)?)) (#endwise! "end"))
((ERROR ("macro" @indent)) @cursor (#endwise! "end"))

; class Foo| - with constant when parser creates it
((ERROR ("class" @indent . (constant) @cursor)) (#endwise! "end"))
; class| - fallback when no constant parsed
((ERROR ("class" @indent)) @cursor (#endwise! "end"))

; struct Foo|
((ERROR ("struct" @indent . (constant) @cursor)) (#endwise! "end"))
((ERROR ("struct" @indent)) @cursor (#endwise! "end"))

; module Foo|
((ERROR ("module" @indent . (constant) @cursor)) (#endwise! "end"))
((ERROR ("module" @indent)) @cursor (#endwise! "end"))

; enum Foo|
((ERROR ("enum" @indent . (constant) @cursor)) (#endwise! "end"))
((ERROR ("enum" @indent)) @cursor (#endwise! "end"))

; lib Foo|
((ERROR ("lib" @indent . (constant) @cursor)) (#endwise! "end"))
((ERROR ("lib" @indent)) @cursor (#endwise! "end"))

; annotation Foo|
((ERROR ("annotation" @indent . (constant) @cursor)) (#endwise! "end"))
((ERROR ("annotation" @indent)) @cursor (#endwise! "end"))

; if condition|
((ERROR ("if" @indent . (_) @cursor)) (#endwise! "end"))
((ERROR ("if" @indent)) @cursor (#endwise! "end"))

; unless condition|
((ERROR ("unless" @indent . (_) @cursor)) (#endwise! "end"))
((ERROR ("unless" @indent)) @cursor (#endwise! "end"))

; while condition|
((ERROR ("while" @indent . (_) @cursor)) (#endwise! "end"))
((ERROR ("while" @indent)) @cursor (#endwise! "end"))

; until condition|
((ERROR ("until" @indent . (_) @cursor)) (#endwise! "end"))
((ERROR ("until" @indent)) @cursor (#endwise! "end"))

; case expression|
((ERROR ("case" @indent . (_) @cursor)) (#endwise! "end"))
((ERROR ("case" @indent)) @cursor (#endwise! "end"))

; begin|
((ERROR ("begin" @indent)) @cursor (#endwise! "end"))

; do|
((ERROR ("do" @indent)) @cursor (#endwise! "end"))
