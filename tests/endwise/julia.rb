config({
  extension: "jl",
  overrides: <<~INIT_LUA
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
INIT_LUA
})

test "julia, struct definition", <<~END
-struct Foo█
+struct Foo
+  
+end
END

test "julia, struct definition with subtype", <<~END
-struct Foo <: Bar█
+struct Foo <: Bar
+  
+end
END

test "julia, struct definition with type param", <<~END
-struct Foo{T}█
+struct Foo{T}
+  
+end
END

test "julia, struct definition with subtype and type param", <<~END
-struct Foo{T} <: Bar{T}█
+struct Foo{T} <: Bar{T}
+  
+end
END

test "julia, function definition", <<~END
-function foo()█
+function foo()
+  
+end
END

test "julia, function definition with return type", <<~END
-function foo()::Int8█
+function foo()::Int8
+  
+end
END

test "julia, macro definition", <<~END
-macro Foo()█
+macro Foo()
+  
+end
END

test "julia, module definition", <<~END
-module Foo█
+module Foo
+
+end
END

test "julia, let statement", <<~END
-let foo = 1█
+let foo = 1
+  
+end
END

test "julia, if stmt", <<~END
-if foo█
+if foo
+  
+end
END

test "julia, for in loop", <<~END
-for foo in bar█
+for foo in bar
+  
+end
END

test "julia, for loop with range", <<~END
-for foo = 1:5█
+for foo = 1:5
+  
+end
END

test "julia, while loop", <<~END
-while foo█
+while foo
+  
+end
END

test "julia, try statement", <<~END
-try█
+try
+  
+end
END

test "julia, quote statement", <<~END
-quote█
+quote
+  
+end
END

test "julia, do clause no arg", <<~END
-get(dict, "a") do█
+get(dict, "a") do
+  
+end
END

test "julia, do clause with arg", <<~END
-map(1:9) do x█
+map(1:9) do x
+  
+end
END

test "julia, begin expression", <<~END
-begin█
+begin
+  
+end
END

test "julia, nested struct definition", <<~END
-struct Foo
-  struct Bar█
-end
+struct Foo
+  struct Bar
+    
+  end
+end
END

test "julia, nested struct definition with subtype", <<~END
-struct Foo <: Bar
-  struct Baz <: Qux█
-end
+struct Foo <: Bar
+  struct Baz <: Qux
+    
+  end
+end
END

test "julia, nested struct definition with type param", <<~END
-struct Foo{T}
-  struct Bar{T}█
-end
+struct Foo{T}
+  struct Bar{T}
+    
+  end
+end
END

test "julia, nested struct definition with subtype and type param", <<~END
-struct Foo{T} <: Bar{T}
-  struct Baz{T} <: Qux{T}█
-end
+struct Foo{T} <: Bar{T}
+  struct Baz{T} <: Qux{T}
+    
+  end
+end
END

test "julia, nested function definition", <<~END
-function foo()
-  function bar()█
-end
+function foo()
+  function bar()
+    
+  end
+end
END

test "julia, nested function definition with return type", <<~END
-function foo()::Int8
-  function bar()::Int8█
-end
+function foo()::Int8
+  function bar()::Int8
+    
+  end
+end
END

test "julia, nested macro definition", <<~END
-macro Foo()
-  macro Bar()█
-end
+macro Foo()
+  macro Bar()
+    
+  end
+end
END

test "julia, nested module definition", <<~END
-module Foo
-module Bar█
-end
+module Foo
+module Bar

+end
+end
END

test "julia, nested let statement", <<~END
-let foo = 1
-  let bar = 2█
-end
+let foo = 1
+  let bar = 2
+    
+  end
+end
END

test "julia, nested if stmt", <<~END
-if foo
-  if bar█
-end
+if foo
+  if bar
+    
+  end
+end
END

test "julia, nested for in loop", <<~END
-for foo in bar
-  for baz in qux█
-end
+for foo in bar
+  for baz in qux
+    
+  end
+end
END

test "julia, nested for loop with range", <<~END
-for foo = 1:5
-  for bar = 1:10█
-end
+for foo = 1:5
+  for bar = 1:10
+    
+  end
+end
END

test "julia, nested while loop", <<~END
-while foo
-  while bar█
-end
+while foo
+  while bar
+    
+  end
+end
END

test "julia, nested try statement", <<~END
-try
-  try█
-end
+try
+  try
+    
+  end
+end
END

test "julia, nested quote statement", <<~END
-quote
-  quote█
-end
+quote
+  quote
+    
+  end
+end
END

test "julia, nested do clause no arg", <<~END
-get(dict, "a") do
-  get(dict, "b") do█
-end
+get(dict, "a") do
+  get(dict, "b") do
+    
+  end
+end
END

test "julia, nested do clause with arg", <<~END
-map(1:9) do x
-  map(1:9) do y█
-end
+map(1:9) do x
+  map(1:9) do y
+    
+  end
+end
END

test "julia, nested begin expression", <<~END
-begin
-  begin█
-end
+begin
+  begin
+    
+  end
+end
END
