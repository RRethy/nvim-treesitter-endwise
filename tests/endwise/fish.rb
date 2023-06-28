config({
  extension: "fish",
  overrides: <<~INIT_LUA
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
INIT_LUA
})

test "fish, global function", <<~END
-function foo█
+function foo
+  
+end
END

test "fish, global function with options", <<~END
-function foo --on-signal WINCH█
+function foo --on-signal WINCH
+  
+end
END

test "fish, while loop", <<~END
-while true█
+while true
+  
+end
END

test "fish, for loop generic clause", <<~END
-for i in (seq 1 5)█
+for i in (seq 1 5)
+  
+end
END

test "fish, if stmt", <<~END
-if foo█
+if foo
+  
+end
END

test "fish, nested global function", <<~END
-function foobarbaz
-  function foo█
-end
+function foobarbaz
+  function foo
+    
+  end
+end
END

test "fish, nested global function with options", <<~END
-function foobarbaz --on-signal WINCH
-  function foo█
-end
+function foobarbaz --on-signal WINCH
+  function foo
+    
+  end
+end
END

test "fish, nested global function with inner options", <<~END
-function foobarbaz
-  function foo --on-signal WINCH█
-end
+function foobarbaz
+  function foo --on-signal WINCH
+    
+  end
+end
END

test "fish, nested while loop", <<~END
-function foobarbaz
-  while true█
-end
+function foobarbaz
+  while true
+    
+  end
+end
END

test "fish, nested for loop loop", <<~END
-function foobarbaz
-  for i in (seq 1 5)█
-end
+function foobarbaz
+  for i in (seq 1 5)
+    
+  end
+end
END

