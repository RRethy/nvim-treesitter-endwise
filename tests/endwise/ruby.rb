config({
  lang: "ruby",
  extension: "rb",
  overrides: <<~INIT_LUA
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
INIT_LUA
})

test "outside of syntax tree works", <<~END
-█
-
-"foobar"
+
+
+
+"foobar"
END

test "normal cr works", <<~END
-"foobar"█
+"foobar"
+
END

test "sequence, indentation is kept", <<~END
-  module Foo█
-def foo
-end
+  module Foo
+    
+  end
+def foo
+end
END

test "sequence, tailing text is kept with indentation", <<~END
-  module Foo█bar
-def foo
-end
+  module Foo
+    bar
+  end
+def foo
+end
END

test "sequence, tailing text is kept with indentation but leading whitespace is stripped", <<~END
-  module Foo█ bar
-def foo
-end
+  module Foo
+    bar
+  end
+def foo
+end
END

test "sequence, unindented text indents newline", <<~END
-module Foo█
-def foo
-end
+module Foo
+  
+end
+def foo
+end
END

# I'm not sure if I want to keep this behaviour of searching up so many lines,
# but for now I like it
test "sequence, we search back to closest non-whitespace", <<~END
-module Foo
-
-█
-def foo
-end
+module Foo
+
+
+  
+end
+def foo
+end
END

test "subtree, basic example works", <<~END
-module Foo█
+module Foo
+  
+end
END

test "subtree", <<~END
-module Foo█bar
+module Foo
+  bar
+end
END

test "subtree, trailing text works as expected", <<~END
-module Foo█ bar
+module Foo
+  bar
+end
END

test "subtree, realizes end belongs to parent", <<~END
-module Foo
-  def foo█
-end
+module Foo
+  def foo
+    
+  end
+end
END

test "valid syntax is no-op", <<~END
-module Foo█
-end
+module Foo
+
+end
END

test "subtree, module works", <<~END
-module Foo█
+module Foo
+  
+end
END

test "subtree, class works", <<~END
-module Foo█
+module Foo
+  
+end
END

test "subtree, method works", <<~END
-def foo█
+def foo
+  
+end
END

test "subtree, singleton_method works", <<~END
-def foo.bar█
+def foo.bar
+  
+end
END

test "sequence, module works", <<~END
-module Foo█
-def foo
-end
+module Foo
+  
+end
+def foo
+end
END

test "sequence, class works", <<~END
-module Foo█
-def foo
-end
+module Foo
+  
+end
+def foo
+end
END

test "sequence, method works", <<~END
-def foo█
-def foo
-end
+def foo
+  
+end
+def foo
+end
END

test "sequence, singleton_method works", <<~END
-def foo.bar█
-def foo
-end
+def foo.bar
+  
+end
+def foo
+end
END

test "while <cond>", <<~END
-while puts('hello')█
+while puts('hello')
+  
+end
END

test "while <cond> do", <<~END
-while puts('hello') do█
+while puts('hello') do
+  
+end
END

test "while <cond> do as sequence", <<~END
-while puts('hello') do█
-def foo
-end
+while puts('hello') do
+  
+end
+def foo
+end
END

test "for loop without do", <<~END
-for foo in 1..5█
+for foo in 1..5
+  
+end
END

test "for loop with do", <<~END
-for foo in 1..5 do█
+for foo in 1..5 do
+  
+end
END

test "sequence, for loop without do", <<~END
-for foo in 1..5█
-def fun
-end
+for foo in 1..5
+  
+end
+def fun
+end
END

test "sequence, for loop with do", <<~END
-for foo in 1..5 do█
-def fun
-end
+for foo in 1..5 do
+  
+end
+def fun
+end
END
