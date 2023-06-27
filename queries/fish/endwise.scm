((function_definition name: (_) @cursor) @endable @indent (#endwise! "end" ))
((while_statement condition: (_) @cursor) @endable @indent (#endwise! "end"))
((for_statement variable: (_) value: (_) @cursor) @endable @indent (#endwise! "end"))
((begin_statement (_) @cursor) @endable @indent (#endwise! "end"))
((switch_statement (_) @cursor) @endable @indent (#endwise! "end"))
((if_statement condition: (_) @cursor) @endable @indent (#endwise! "end"))

((ERROR ("function" . (_)+ @cursor) @indent) (#endwise! "end" ))
((ERROR ("while" . (_) @cursor) @indent) (#endwise! "end"))
((ERROR ("for" . (_) . "in" . (_) @cursor) @indent) (#endwise! "end"))
((ERROR ("begin" @cursor) @indent) (#endwise! "end"))
((ERROR ("switch" . (_) @cursor) @indent) (#endwise! "end"))
((ERROR ("if" . (_) @cursor) @indent) (#endwise! "end"))

