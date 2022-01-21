(
    [
        (module)
        (class)
        (method)
        (singleton_method)
    ] @capture
    (#annotate! "subtree")
    (#endwise-end! "end")
)


(
    (ERROR
        (
            "module" @indent
            .
            [(constant) (scope_resolution)] @tail
        )
    )
    (#annotate! "sequence")
    (#endwise-end! "end")
)

(
    (ERROR
        (
            "class" @indent
            .
            [(constant) (scope_resolution)] @tail
            .
            (superclass)? @tail
        )
    )
    (#annotate! "sequence")
    (#endwise-end! "end")
)

(
    (ERROR
        (
            "def" @indent
            .
            (identifier) @tail
            .
            (method_parameters)? @tail
        )
    )
    (#annotate! "sequence")
    (#endwise-end! "end")
)

(
    (ERROR
        (
            "def" @indent
            .
            (identifier) "."
            .
            (identifier) @tail
            .
            (method_parameters)? @tail
        )
    )
    (#annotate! "sequence")
    (#endwise-end! "end")
)

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
