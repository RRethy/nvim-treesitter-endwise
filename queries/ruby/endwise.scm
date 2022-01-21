((module name: (_) @cursor) @endable @indent (#endwise! "end"))
((class name: (_) @cursor superclass: (_)? @cursor) @endable @indent (#endwise! "end"))
((method name: (_) @cursor parameters: (_)? @cursor) @endable @indent (#endwise! "end"))
((singleton_method name: (_) @cursor parameters: (_)? @cursor) @endable @indent (#endwise! "end"))
((while condition: (_) @cursor body: (do ("do")? @cursor) @endable) @indent (#endwise! "end"))
((for value: (_) @cursor body: (do ("do")? @cursor) @endable) @indent (#endwise! "end"))

((ERROR ("module" @indent . [(constant) (scope_resolution)] @cursor)) (#endwise! "end"))
((ERROR ("class" @indent . [(constant) (scope_resolution)] @cursor . (superclass)? @cursor)) (#endwise! "end"))
((ERROR ("def" @indent . (identifier) @cursor . (method_parameters)? @cursor)) (#endwise! "end"))
((ERROR ("def" @indent . (identifier) . "." . (identifier) @cursor . (method_parameters)? @cursor)) (#endwise! "end"))
((ERROR ("while" @indent . (_) @cursor . "do"? @cursor)) (#endwise! "end"))
((ERROR ("for" @indent . (_) . (in . "in" . (_) @cursor) . "do"? @cursor)) (#endwise! "end"))

;; TODO: if/else still doesn't work

; (
;     "if" @start
;     .
;     (_) @end
; )

; (
;     "if" @start
;     .
;     (_)
;     .
;     "then" @end
; )

; (
;     "if" @start
;     .
;     (_)
;     .
;     (then ("then") @end)
; )

; (
;     "if" @start
;     .
;     (_)
;     .
;     (then)
;     .
;     "else" @end
; )

; (
;     "if" @start
;     .
;     (_)
;     .
;     "else" @end
; )

; (
;     "if" @start
;     .
;     (_)
;     .
;     "elsif"
;     .
;     (_) @end
; )

; (
;     "if" @start
;     .
;     (_)
;     .
;     "elsif"
;     .
;     (_)
;     .
;     "then" @end
; )

; (
;     "if" @start
;     .
;     (_)
;     .
;     "elsif"
;     .
;     (_)
;     .
;     (then ("then") @end)
; )

; (
;     "if" @start
;     .
;     (_)
;     .
;     "elsif"
;     .
;     (_)
;     .
;     (then)
;     .
;     "else" @end
; )

; (
;     "if" @start
;     .
;     (_)
;     .
;     "elsif"
;     .
;     (_)
;     .
;     "else" @end
; )
