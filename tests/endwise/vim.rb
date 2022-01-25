config({
  extension: "vim",
  overrides: <<~INIT_LUA
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
INIT_LUA
})

test "vim, global function", <<~END
-function Foo()█
+function Foo()
+  
+endfunction
END

test "vim, script local function", <<~END
-function s:foo()█
+function s:foo()
+  
+endfunction
END

test "vim, function overwrite", <<~END
-function! Foo()█
+function! Foo()
+  
+endfunction
END

test "vim, ranged function", <<~END
-function Foo() range█
+function Foo() range
+  
+endfunction
END

test "vim, dictionary function", <<~END
-function Foo() dict█
+function Foo() dict
+  
+endfunction
END

test "vim, closure", <<~END
-function Foo() closure█
+function Foo() closure
+  
+endfunction
END

test "vim, abort function", <<~END
-function Foo() abort█
+function Foo() abort
+  
+endfunction
END

test "vim, abort closure", <<~END
-function Foo() closure abort█
+function Foo() closure abort
+  
+endfunction
END

test "vim, if stmt", <<~END
-if foo█
+if foo
+  
+endif
END

test "vim, for loop", <<~END
-for foo in bar█
+for foo in bar
+  
+endfor
END

test "vim, while loop", <<~END
-while foo█
+while foo
+  
+endwhile
END

test "vim, try", <<~END
-try█
+try
+  
+endtry
END

test "vim, nested global function", <<~END
-function Foo()
-  function Bar()█
-endfunction
+function Foo()
+  function Bar()
+    
+  endfunction
+endfunction
END

test "vim, nested script local function", <<~END
-function s:foo()
-  function s:bar()█
-endfunction
+function s:foo()
+  function s:bar()
+    
+  endfunction
+endfunction
END

test "vim, nested while loop", <<~END
-while true
-  while true█
-endwhile
+while true
+  while true
+    
+  endwhile
+endwhile
END

test "vim, nested for loop", <<~END
-for foo in bar
-  for baz in qux█
-endfor
+for foo in bar
+  for baz in qux
+    
+  endfor
+endfor
END

test "vim, nested if stmt", <<~END
-if foo
-  if bar█
-endif
+if foo
+  if bar
+    
+  endif
+endif
END

test "vim, nested try", <<~END
-try
-  try█
-endtry
+try
+  try
+    
+  endtry
+endtry
END

test "vim, nested global function has dynamic end text", <<~END
-func! Foo()
-  fun Bar()█
-endfunc
+func! Foo()
+  fun Bar()
+    
+  endfun
+endfunc
END

test "vim, global function has dynamic end text", <<~END
-fun Bar()█
+fun Bar()
+  
+endfun
END
