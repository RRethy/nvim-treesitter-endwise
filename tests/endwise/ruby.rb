config({
  extension: "rb",
  overrides: <<~INIT_LUA
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
INIT_LUA
})

test "ruby, outside of syntax tree works", <<~END
-█
-
-"foobar"
+
+
+
+"foobar"
END

test "ruby, normal cr works", <<~END
-"foobar"█
+"foobar"
+
END

test "ruby, sequence, indentation is kept", <<~END
-  module Foo█
-def foo
-end
+  module Foo
+    
+  end
+def foo
+end
END

test "ruby, sequence, tailing text is kept with indentation", <<~END
-  module Foo█bar
-def foo
-end
+  module Foo
+    bar
+  end
+def foo
+end
END

test "ruby, sequence, tailing text is kept with indentation but leading whitespace is stripped", <<~END
-  module Foo█ bar
-def foo
-end
+  module Foo
+    bar
+  end
+def foo
+end
END

test "ruby, sequence, unindented text indents newline", <<~END
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
test "ruby, sequence, we search back to closest non-whitespace", <<~END
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

test "ruby, subtree, basic example works", <<~END
-module Foo█
+module Foo
+  
+end
END

test "ruby, subtree", <<~END
-module Foo█bar
+module Foo
+  bar
+end
END

test "ruby, subtree, trailing text works as expected", <<~END
-module Foo█ bar
+module Foo
+  bar
+end
END

test "ruby, subtree, realizes end belongs to parent", <<~END
-module Foo
-  def foo█
-end
+module Foo
+  def foo
+    
+  end
+end
END

test "ruby, valid syntax is no-op", <<~END
-module Foo█
-end
+module Foo
+  
+end
END

test "ruby, subtree, module works", <<~END
-module Foo█
+module Foo
+  
+end
END

test "ruby, subtree, class works", <<~END
-class Foo█
+class Foo
+  
+end
END

test "ruby, subtree, method works", <<~END
-def foo█
+def foo
+  
+end
END

test "ruby, subtree, singleton_method works", <<~END
-def foo.bar█
+def foo.bar
+  
+end
END

test "ruby, sequence, module works", <<~END
-module Foo█
-def foo
-end
+module Foo
+  
+end
+def foo
+end
END

test "ruby, sequence, class works", <<~END
-class Foo█
-def foo
-end
+class Foo
+  
+end
+def foo
+end
END

test "ruby, sequence, method works", <<~END
-def foo█
-def foo
-end
+def foo
+  
+end
+def foo
+end
END

test "ruby, sequence, singleton_method works", <<~END
-def foo.bar█
-def foo
-end
+def foo.bar
+  
+end
+def foo
+end
END

test "ruby, while <cond>", <<~END
-while puts('hello')█
+while puts('hello')
+  
+end
END

test "ruby, while <cond> do", <<~END
-while puts('hello') do█
+while puts('hello') do
+  
+end
END

test "ruby, while <cond> do as sequence", <<~END
-while puts('hello') do█
-def foo
-end
+while puts('hello') do
+  
+end
+def foo
+end
END

test "ruby, until <cond>", <<~END
-until puts('hello')█
+until puts('hello')
+  
+end
END

test "ruby, until <cond> do", <<~END
-until puts('hello') do█
+until puts('hello') do
+  
+end
END

test "ruby, until <cond> do as sequence", <<~END
-until puts('hello') do█
-def foo
-end
+until puts('hello') do
+  
+end
+def foo
+end
END

test "ruby, for loop without do", <<~END
-for foo in 1..5█
+for foo in 1..5
+  
+end
END

test "ruby, for loop with do", <<~END
-for foo in 1..5 do█
+for foo in 1..5 do
+  
+end
END

test "ruby, sequence, for loop without do", <<~END
-for foo in 1..5█
-def fun
-end
+for foo in 1..5
+  
+end
+def fun
+end
END

test "ruby, sequence, for loop with do", <<~END
-for foo in 1..5 do█
-def fun
-end
+for foo in 1..5 do
+  
+end
+def fun
+end
END

test "ruby, do block", <<~END
-foo.each do█
+foo.each do
+  
+end
END

test "ruby, do block with args", <<~END
-foo.each do |bar, baz|█
+foo.each do |bar, baz|
+  
+end
END

test "ruby, sequence, do block", <<~END
-foo.each do█
-def foo
-end
+foo.each do
+  
+end
+def foo
+end
END

test "ruby, sequence, do block with args", <<~END
-foo.each do |bar, baz|█
-def foo
-end
+foo.each do |bar, baz|
+  
+end
+def foo
+end
END

test "ruby, if stmt", <<~END
-if true█
+if true
+  
+end
END

test "ruby, sequence, if stmt", <<~END
-if true█
-def foo
-end
+if true
+  
+end
+def foo
+end
END

test "ruby, if stmt then", <<~END
-if true then█
+if true then
+  
+end
END

test "ruby, sequence, if stmt then", <<~END
-if true then█
-def foo
-end
+if true then
+  
+end
+def foo
+end
END

test "ruby, unless stmt", <<~END
-unless true█
+unless true
+  
+end
END

test "ruby, sequence, unless stmt", <<~END
-unless true█
-def foo
-end
+unless true
+  
+end
+def foo
+end
END

test "ruby, unless stmt then", <<~END
-unless true then█
+unless true then
+  
+end
END

test "ruby, sequence, unless stmt then", <<~END
-unless true then█
-def foo
-end
+unless true then
+  
+end
+def foo
+end
END

test "ruby, case stmt", <<~END
-case foo█
+case foo
+
+end
END

test "ruby, nested case stmt", <<~END
-case foo
-when 0
-  case bar█
-end
+case foo
+when 0
+  case bar
+  
+  end
+end
END

test "ruby, begin stmt", <<~END
-begin█
+begin
+  
+end
END

test "ruby, begin stmt rescue", <<~END
-begin
-rescue█
+begin
+rescue
+  
+end
END

test "ruby, begin stmt rescue with exceptions", <<~END
-begin
-rescue String█
+begin
+rescue String
+  
+end
END

test "ruby, begin stmt rescue ensure", <<~END
-begin
-rescue String
-ensure█
+begin
+rescue String
+ensure
+  
+end
END

test "ruby, valueless case stmt", <<~END
-case█
+case
+
+end
END

test "ruby, heredoc", <<~END
-test "foo", <<~FOO█
+test "foo", <<~FOO
+
+FOO
END

test "ruby, sequence, superclass works", <<~END
-class Foo < self█
-def foo
-end
+class Foo < self
+  
+end
+def foo
+end
END

test "ruby, subtree, superclass works", <<~END
-class Foo < self█
+class Foo < self
+  
+end
END

test "ruby, sequence, singleton class", <<~END
-class << self█
-def foo
-end
+class << self
+  
+end
+def foo
+end
END

test "ruby, subtree, singleton class", <<~END
-class << self█
+class << self
+  
+end
END

test "ruby, inside function params", <<~END
-def foo(█)
+def foo(
+  )
+end
END
