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

test "lua, nested global function", <<~END
-function Foo()
-  function Bar()█
-endfunction
+function Foo()
+  function Bar()
+    
+  endfunction
+endfunction
END

test "lua, nested script local function", <<~END
-function s:foo()
-  function s:bar()█
-endfunction
+function s:foo()
+  function s:bar()
+    
+  endfunction
+endfunction
END

test "lua, nested while loop", <<~END
-function Foo()
-  while true█
-endfunction
+function Foo()
+  while true
+    
+  endwhile
+endfunction
END

test "lua, nested for loop", <<~END
-function Foo()
-  for bar in baz█
-endfunction
+function Foo()
+  for bar in baz
+    
+  endfor
+endfunction
END

test "lua, nested if stmt", <<~END
-function Foo()
-  if foo█
-endfunction
+function Foo()
+  if foo
+    
+  endif
+endfunction
END

test "lua, nested try", <<~END
-function Foo()
-  try█
-endfunction
+function Foo()
+  try
+    
+  endtry
+endfunction
END
