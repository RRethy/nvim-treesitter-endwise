((module_declaration
   . [(module_nonansi_header ";") (module_ansi_header ";")] @cursor) @endable @indent
 (#endwise! "endmodule"))
([(module_nonansi_header ";" @cursor)
  (module_ansi_header ";" @cursor)] @endable @indent
 (#endwise! "endmodule"))
((ERROR ("module" . [ (simple_identifier) (escaped_identifier) ] . ";" @cursor) @indent) (#endwise! "endmodule"))
((interface_declaration
   . [(interface_nonansi_header ";") (interface_ansi_header ";")] @cursor) @endable @indent
 (#endwise! "endinterface"))
([(interface_nonansi_header ";" @cursor)
  (interface_ansi_header ";" @cursor)] @endable @indent
 (#endwise! "endinterface"))
((ERROR ("interface" . [ (simple_identifier) (escaped_identifier) ] . ";" @cursor) @indent) (#endwise! "endinterface"))
((class_declaration . "virtual"? . "class" ";" @cursor) @endable @indent
 (#endwise! "endclass"))
((ERROR ("class" . [ (simple_identifier) (escaped_identifier) ]? . ";" @cursor) @indent (#endwise! "endclass")))
((interface_class_declaration . "interface" . "class" ";" @cursor) @endable @indent
 (#endwise! "endclass"))
((ERROR ("interface" . "class" . [ (simple_identifier) (escaped_identifier) ] . ";" @cursor) @indent (#endwise! "endclass")))
((package_declaration . "package" ";" @cursor) @endable @indent
 (#endwise! "endpackage"))
((ERROR ("package" . [ (simple_identifier) (escaped_identifier) ] . ";" @cursor) @indent) (#endwise! "endpackage"))
((class_constructor_declaration . "function" ";" @cursor) @endable @indent
 (#endwise! "endfunction: new"))
((ERROR 
   [("function" . "new" . ";" @cursor)
    ("function" . "new" . "(" . (class_constructor_arg_list)? . ")" . ";" @cursor)]
   @indent) (#endwise! "endfunction: new"))
((function_body_declaration . (_) ";" @cursor) @endable @indent
 (#endwise! "endfunction"))
((ERROR 
   [("function" . [ (simple_identifier) (escaped_identifier) ] . ";" @cursor)
    ("function" . [ (simple_identifier) (escaped_identifier) ] . "(" . (tf_port_list)? . ")" . ";" @cursor)]
   @indent) (#endwise! "endfunction"))
((task_body_declaration . (_) ";" @cursor) @endable @indent
 (#endwise! "endtask"))
((ERROR 
   [("task" . [ (simple_identifier) (escaped_identifier) ] . ";" @cursor)
    ("task" . [ (simple_identifier) (escaped_identifier) ] . "(" . (tf_port_list)? . ")" . ";" @cursor)]
   @indent) (#endwise! "endtask"))
((property_declaration . "property" ";" @cursor) @endable @indent
 (#endwise! "endproperty"))
((ERROR 
   [("property" . [ (simple_identifier) (escaped_identifier) ] . ";" @cursor)
    ("property" . [ (simple_identifier) (escaped_identifier) ] . "(" . (property_port_list)? . ")" . ";" @cursor)]
   @indent) (#endwise! "endproperty"))
((generate_region . "generate" @cursor) @endable @indent
 (#endwise! "endgenerate"))
((ERROR ("generate" @cursor) @indent) (#endwise! "endgenerate"))
((case_generate_construct . "case" "(" (_) ")" @cursor) @endable @indent
 (#endwise! "endcase"))
([(generate_block . (_) . "begin" @cursor)
  (generate_block . (_) . "begin" ":" name: (_) @cursor)] @endable @indent
 (#endwise! "end"))
([(seq_block . "begin" @cursor) 
  (seq_block . "begin" ":" (_) @cursor)] @endable @indent
 (#endwise! "end"))
((ERROR ("begin" @cursor) @indent) (#endwise! "end"))
((par_block
   . [ "fork" ("fork" ":" (_)) ] @cursor
 ) @endable @indent
 (#endwise! "join"))
((ERROR ("fork" @cursor) @indent) (#endwise! "join"))
([(case_statement . [ "case" (case_keyword) ] "(" (_) ")" "inside" @cursor)
  (case_statement . [ "case" (case_keyword) ] "(" (_) ")" @cursor)] @endable @indent
 (#endwise! "endcase"))
((ERROR
   [("case" . "(" . (_) . ")" . "inside" @cursor)
    ("case" . "(" . (_) . ")" @cursor)]
   @indent) (#endwise! "endcase"))
