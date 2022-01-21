((module name: (_) @cursor) @indent (#endwise! "end"))
((class name: (_) @cursor superclass: (_)? @cursor) @indent (#endwise! "end"))
((method name: (_) @cursor parameters: (_)? @cursor) @indent (#endwise! "end"))
((singleton_method name: (_) @cursor parameters: (_)? @cursor) @indent (#endwise! "end"))
; ((do) @cursor @indent (#endwise! "end")) ; while

((ERROR ("module" @indent . [(constant) (scope_resolution)] @cursor)) (#endwise! "end"))
((ERROR ("class" @indent . [(constant) (scope_resolution)] @cursor . (superclass)? @cursor)) (#endwise! "end"))
((ERROR ("def" @indent . (identifier) @cursor . (method_parameters)? @cursor)) (#endwise! "end"))
((ERROR ("def" @indent . (identifier) "." . (identifier) @cursor . (method_parameters)? @cursor)) (#endwise! "end"))
((ERROR ("while" @indent . (identifier) "." . (identifier) @cursor . (method_parameters)? @cursor)) (#endwise! "end"))

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
