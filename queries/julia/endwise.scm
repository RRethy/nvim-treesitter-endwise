((module_definition name: (_) @cursor) @indent @endable
 (#endwise! "end"))
((ERROR ["module" "baremodule"] @indent . (_) @cursor)
 (#endwise! "end"))

((struct_definition
   (type_head) @cursor
 ) @indent @endable
 (#endwise! "end"))

((ERROR "mutable"? "struct" @indent
   . (type_head) @cursor
 )
 (#endwise! "end"))

((quote_statement "quote" @cursor) @indent @endable
 (#endwise! "end"))

((ERROR "quote" @indent @cursor)
 (#endwise! "end"))

((if_statement condition: (_) @cursor) @indent @endable
 (#endwise! "end"))

((ERROR "if" @indent . (_) @cursor)
 (#endwise! "end"))

((try_statement "try" @cursor) @indent @endable
 (#endwise! "end"))

((ERROR "try" @indent @cursor)
 (#endwise! "end"))

((for_statement . (for_binding)* . (for_binding) @cursor) @indent @endable
 (#endwise! "end"))

((ERROR "for" @indent . (for_binding)* . (for_binding) @cursor)
 (#endwise! "end"))

((while_statement condition: (_) @cursor) @indent @endable
 (#endwise! "end"))

((ERROR "while" @indent . (_) @cursor)
 (#endwise! "end"))

((let_statement "let" @cursor
  [(identifier) (let_binding)]? @cursor
 ) @indent @endable
 (#endwise! "end"))

((ERROR "let" @cursor @indent
  [(identifier) (let_binding) (assignment)]? @cursor
 )
 (#endwise! "end"))

((function_definition (signature
   [(identifier) (call_expression) (typed_expression) (where_expression)] @cursor
 )) @indent @endable
 (#endwise! "end"))

((ERROR "function" @indent . (signature
   [(identifier) (call_expression) (typed_expression) (where_expression)] @cursor
 ))
 (#endwise! "end"))

; anonymous function
((function_definition (signature
   (argument_list) @cursor
   (where_expression)? @cursor
 )) @indent @endable
 (#endwise! "end"))

((ERROR "function" @indent . (signature 
   (argument_list) @cursor
   (where_expression)? @cursor
 ))
 (#endwise! "end"))

((macro_definition
   (signature [(identifier) (call_expression)]) @cursor
 ) @indent @endable
 (#endwise! "end"))

((ERROR "macro" @indent .
   (signature [(identifier) (call_expression)]) @cursor
 )
 (#endwise! "end"))

((do_clause ["do" (argument_list)] @cursor) @indent @endable
 (#endwise! "end"))

((ERROR ["do" (argument_list)] @cursor @indent)
 (#endwise! "end"))

((compound_statement "begin" @cursor) @indent @endable
 (#endwise! "end"))

((ERROR "begin" @cursor @indent)
 (#endwise! "end"))

; assignment variant
("->" @indent (identifier) @cursor
 (#endwise! "end"))

; eof variant
((identifier) @cursor @indent (ERROR)
 (#endwise! "end"))
