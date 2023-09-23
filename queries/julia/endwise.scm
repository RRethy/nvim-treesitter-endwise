((module_definition name: (_) @cursor) @indent @endable
 (#endwise! "end"))
((ERROR ["module" "baremodule"] @indent . (_) @cursor)
 (#endwise! "end"))

((struct_definition
   name: (_) @cursor
   (type_parameter_list)? @cursor
   (type_clause)? @cursor
 ) @indent @endable
 (#endwise! "end"))

((ERROR "mutable"? "struct" @indent
   . (identifier) @cursor
   . (curly_expression)? @cursor
   . (type_clause)? @cursor
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

((for_statement (for_binding) @cursor) @indent @endable
 (#endwise! "end"))

((ERROR "for" (for_binding) @cursor @indent .)
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
  [(identifier) (named_field) (let_binding)]? @cursor @indent .
 )
 (#endwise! "end"))

((function_definition
   name: (_)? @cursor
   parameters: (parameter_list)? @cursor
   return_type: (identifier)? @cursor
   (where_clause)? @cursor
 ) @indent @endable
 (#endwise! "end"))

((ERROR "function" @indent
   name: (_)? @cursor
   parameters: (parameter_list)? @cursor
   return_type: (identifier)? @cursor
   (where_clause)? @cursor
 )
 (#endwise! "end"))

; anonymous function
((ERROR "function" @indent
   (parameter_list) @cursor
   (where_clause)? @cursor
 )
 (#endwise! "end"))

((macro_definition
   name: (_) @cursor
   parameters: (parameter_list)? @cursor
 ) @indent @endable
 (#endwise! "end"))

((ERROR "macro" @indent
   . (_) @cursor
   . (parameter_list)? @cursor
 )
 (#endwise! "end"))

((do_clause ["do" (parameter_list)] @cursor) @indent @endable
 (#endwise! "end"))

((ERROR ["do" (parameter_list)] @cursor @indent)
 (#endwise! "end"))

((compound_statement "begin" @cursor) @endable @indent
 (#endwise! "end"))

((ERROR "begin" @cursor @indent)
 (#endwise! "end"))

; assignment variant
("->" @indent (identifier) @cursor
 (#endwise! "end"))

; eof variant
((identifier) @cursor @indent (ERROR "\n")
 (#endwise! "end"))
