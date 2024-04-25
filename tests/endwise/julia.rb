config({
  extension: "jl",
  overrides: <<~INIT_LUA
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
INIT_LUA
})

test "julia, outside of syntax tree works", <<~END
-█
-
-"foobar"
+
+
+
+"foobar"
END

test "julia, normal cr works", <<~END
-"foobar"█
+"foobar"
+
END

##################################################

test "julia, module, simple", <<~END
-module Foo█
+module Foo
+  
+end
END

test "julia, module, baremodule", <<~END
-baremodule Foo█
+baremodule Foo
+  
+end
END

test "julia, module, nested", <<~END
-module Foo
-  module Bar█
-end
+module Foo
+  module Bar
+    
+  end
+end
END

test "julia, module, nested double 1", <<~END
-baremodule Foo
-  module Bar
-  end
-  module Baz█
-end
+baremodule Foo
+  module Bar
+  end
+  module Baz
+    
+  end
+end
END

test "julia, module, nested double 2", <<~END
-baremodule Foo
-  module Baz█
-  module Bar
-  end
-end
+baremodule Foo
+  module Baz
+    
+  end
+  module Bar
+  end
+end
END

test "julia, module, incomplete 1", <<~END
-module Foo
-  baremodule Bar█
+module Foo
+  baremodule Bar
+    
+  end
END

test "julia, module, incomplete 2", <<~END
-baremodule Foo
-  module Bar█
+baremodule Foo
+  module Bar
+    
+  end
END

################################################## 

test "julia, struct, simple", <<~END
-struct Foo█
+struct Foo
+  
+end
END

test "julia, struct, mutable", <<~END
-mutable struct Foo█
+mutable struct Foo
+  
+end
END

test "julia, struct, subtype", <<~END
-struct Foo <: Bar█
+struct Foo <: Bar
+  
+end
END

test "julia, struct, definition with type param", <<~END
-struct Foo{T}█
+struct Foo{T}
+  
+end
END

test "julia, struct, definition with subtype and type param", <<~END
-struct Foo{T} <: Bar{T}█
+struct Foo{T} <: Bar{T}
+  
+end
END

test "julia, struct, correct indent 1", <<~END
-struct Foo{
-    }█
+struct Foo{
+    }
+  
+end
END

test "julia, struct, correct indent 2", <<~END
-struct Foo{} <: Bar{T
-    }█
+struct Foo{} <: Bar{T
+    }
+  
+end
END

test "julia, struct, correct indent 3", <<~END
-struct Foo{} <:
-    Bar{T}█
+struct Foo{} <:
+    Bar{T}
+  
+end
END

test "julia, struct, nested 1", <<~END
-struct Foo <: Bar
-  mutable struct Baz{T}█
-end
+struct Foo <: Bar
+  mutable struct Baz{T}
+    
+  end
+end
END

test "julia, struct, nested 2", <<~END
-mutable struct Foo{T} <: Bar{T}
-  struct Baz{T, U}█
-end
+mutable struct Foo{T} <: Bar{T}
+  struct Baz{T, U}
+    
+  end
+end
END

test "julia, struct, nested double 1", <<~END
-struct Foo
-  mutable struct Bar{T}
-  end
-  struct Baz{U}█
-end
+struct Foo
+  mutable struct Bar{T}
+  end
+  struct Baz{U}
+    
+  end
+end
END

test "julia, struct, nested double 2", <<~END
-struct Foo
-  struct Baz{U}█
-  mutable struct Bar{T}
-  end
-end
+struct Foo
+  struct Baz{U}
+    
+  end
+  mutable struct Bar{T}
+  end
+end
END

test "julia, struct, incomplete", <<~END
-mutable struct Foo
-  struct Bar{T <: Int} <: Baz{T}█
+mutable struct Foo
+  struct Bar{T <: Int} <: Baz{T}
+    
+  end
END

################################################## 

test "julia, quote, simple", <<~END
-quote█
+quote
+  
+end
END

test "julia, quote, assignment indent", <<~end
-x = quote█
+x = quote
+  
+end
end

test "julia, quote, nested", <<~END
-quote
-  x = quote█
-end
+quote
+  x = quote
+    
+  end
+end
END

test "julia, quote, nested double 1", <<~END
-quote
-  quote
-  end
-  x = quote█
-end
+quote
+  quote
+  end
+  x = quote
+    
+  end
+end
END

test "julia, quote, nested double 2", <<~END
-quote
-  x = quote█
-  quote
-  end
-end
+quote
+  x = quote
+    
+  end
+  quote
+  end
+end
END

test "julia, quote, incomplete 1", <<~END
-quote
-  x = quote█
+quote
+  x = quote
+    
+  end
END

test "julia, quote, incomplete 2", <<~END
-x = quote
-  quote█
+x = quote
+  quote
+    
+  end
END

##################################################

test "julia, if, literal", <<~END
-if true█
+if true
+  
+end
END

test "julia, if, negation", <<~END
-if !true█
+if !true
+  
+end
END

test "julia, if, predicate", <<~END
-if pred()█
+if pred()
+  
+end
END

# broken due to a bug in ts parser https://github.com/tree-sitter/tree-sitter-julia/issues/117
# test "julia, if, expression 1", <<~END
# -if 1 + 1 == 2█
# +if 1 + 1 == 2
# +  
# +end
# END

test "julia, if, expression 2", <<~END
-if 2 == 1 + 1█
+if 2 == 1 + 1
+  
+end
END

test "julia, if, expression 3", <<~END
-if !(a && true)█
+if !(a && true)
+  
+end
END

test "julia, if, correct indent 1", <<~END
-if !(a && true
-    )█
+if !(a && true
+    )
+  
+end
END

test "julia, if, correct indent 2", <<~END
-if a ||
-    b█
+if a ||
+    b
+  
+end
END

test "julia, if, correct indent 3", <<~END
-if a(
-    )█
+if a(
+    )
+  
+end
END

test "julia, if, nested", <<~END
-if !(a && b)
-  if bar█
-end
+if !(a && b)
+  if bar
+    
+  end
+end
END

test "julia, if, nested with alternatives 1", <<~END
-if foo
-elseif baz
-  if 2 < 1█
-else
-end
+if foo
+elseif baz
+  if 2 < 1
+    
+  end
+else
+end
END

test "julia, if, nested with alternatives 2", <<~END
-if foo
-elseif bar
-else
-  if baz█
-end
+if foo
+elseif bar
+else
+  if baz
+    
+  end
+end
END

test "julia, if, nested double 1", <<~END
-if !(a && b)
-  if true
-  end
-  if bar█
-end
+if !(a && b)
+  if true
+  end
+  if bar
+    
+  end
+end
END

test "julia, if, nested double 2", <<~END
-if !(a && b)
-else
-  if true
-  elseif false
-  end
-  if bar█
-end
+if !(a && b)
+else
+  if true
+  elseif false
+  end
+  if bar
+    
+  end
+end
END

test "julia, if, incomplete 1", <<~END
-if foo
-elseif true
-elseif true
-  if !bar█
+if foo
+elseif true
+elseif true
+  if !bar
+    
+  end
END

test "julia, if, incomplete 2", <<~END
-if foo
-  if !bar█
-elseif true
-else
+if foo
+  if !bar
+    
+  end
+elseif true
+else
END

################################################## 

test "julia, try catch, single", <<~END
-try█
+try
+  
+end
END

test "julia, try catch, assignment indent", <<~END
-x = try█
+x = try
+  
+end
END

test "julia, try catch, nested 1", <<~END
-try
-finally
-  try█
-end
+try
+finally
+  try
+    
+  end
+end
END

test "julia, try catch, nested 2", <<~END
-try
-catch e
-  x = try█
-end
+try
+catch e
+  x = try
+    
+  end
+end
END

test "julia, try catch, nested double 1", <<~END
-try
-catch e
-  try
-  finally
-  end
-  x = try█
-end
+try
+catch e
+  try
+  finally
+  end
+  x = try
+    
+  end
+end
END

test "julia, try catch, nested double 2", <<~END
-try
-finally
-  x = try█
-  try
-  catch e
-  end
-end
+try
+finally
+  x = try
+    
+  end
+  try
+  catch e
+  end
+end
END

test "julia, try catch, incomplete", <<~END
-try
-catch
-else
-  x = try█
+try
+catch
+else
+  x = try
+    
+  end
END

################################################## 

test "julia, for loop, simple", <<~END
-for i in 1:10█
+for i in 1:10
+  
+end
END

test "julia, for loop, function", <<~END
-for i ∈ f()█
+for i ∈ f()
+  
+end
END

test "julia, for loop, double", <<~END
-for i in 1:10, j = 1:10█
+for i in 1:10, j = 1:10
+  
+end
END

test "julia, for loop, correct indent 1", <<~END
-for i in f(
-    )█
+for i in f(
+    )
+  
+end
END

test "julia, for loop, correct indent 2", <<~END
-for i = 1:10,
-    j = 1:10█
+for i = 1:10,
+    j = 1:10
+  
+end
END

test "julia, for loop, correct indent 3", <<~END
-for i in 1:10, j in f(
-    )█
+for i in 1:10, j in f(
+    )
+  
+end
END

test "julia, for loop, nested 1", <<~END
-for i in 1:10, j in list1
-  for (k, l) in list2█
-end
+for i in 1:10, j in list1
+  for (k, l) in list2
+    
+  end
+end
END

test "julia, for loop, nested 2", <<~END
-for i in list1
-  for i ∈ 1:10█
-end
+for i in list1
+  for i ∈ 1:10
+    
+  end
+end
END

test "julia, for loop, nested double 1", <<~END
-for i in 1:10, j in f()
-  for k in 1:10
-  end
-  for (l, m) in list█
-end
+for i in 1:10, j in f()
+  for k in 1:10
+  end
+  for (l, m) in list
+    
+  end
+end
END

test "julia, for loop, nested double 2", <<~END
-for i in 1:10, j in list1
-  for (l, m) in list2█
-  for k in 1:10
-  end
-end
+for i in 1:10, j in list1
+  for (l, m) in list2
+    
+  end
+  for k in 1:10
+  end
+end
END

test "julia, for loop, incomplete", <<~END
-for i ∈ 1:10
-  for j = 1:10, i in f()█
+for i ∈ 1:10
+  for j = 1:10, i in f()
+    
+  end
END

##################################################

test "julia, while, literal", <<~END
-while true█
+while true
+  
+end
END

test "julia, while, negation", <<~END
-while !true█
+while !true
+  
+end
END

test "julia, while, predicate", <<~END
-while pred()█
+while pred()
+  
+end
END

test "julia, while, correct indent 1", <<~END
-while !(a && true
-    )█
+while !(a && true
+    )
+  
+end
END

test "julia, while, correct indent 2", <<~END
-while a ||
-    b█
+while a ||
+    b
+  
+end
END

test "julia, while, correct indent 3", <<~END
-while a(
-    )█
+while a(
+    )
+  
+end
END

# broken due to a bug in ts parser https://github.com/tree-sitter/tree-sitter-julia/issues/117
# test "julia, while, expression 1", <<~END
# -while 1 + 1 == 2█
# +while 1 + 1 == 2
# +  
# +end
# END

test "julia, while, expression 2", <<~END
-while 2 == 1 + 1█
+while 2 == 1 + 1
+  
+end
END

test "julia, while, expression 3", <<~END
-while !(a && true)█
+while !(a && true)
+  
+end
END

test "julia, while, nested", <<~END
-while x < 10
-  while 2 == 1 + 1█
-end
+while x < 10
+  while 2 == 1 + 1
+    
+  end
+end
END

test "julia, while, nested double 1", <<~END
-while x < 10
-  while y < 20
-  end
-  while 2 == 1 + 1█
-end
+while x < 10
+  while y < 20
+  end
+  while 2 == 1 + 1
+    
+  end
+end
END

test "julia, while, nested double 2", <<~END
-while x < 10
-  while 2 == 1 + 1█
-  while y < f()
-  end
-end
+while x < 10
+  while 2 == 1 + 1
+    
+  end
+  while y < f()
+  end
+end
END

test "julia, while, incomplete", <<~END
-while x < 10
-  while pred()█
+while x < 10
+  while pred()
+    
+  end
END

##################################################

test "julia, let, empty", <<~END
-let█
+let
+  
+end
END

test "julia, let, arguments", <<~END
-let x, y = 1█
+let x, y = 1
+  
+end
END

test "julia, let, with assignment", <<~END
-a = let x = 1, z█
+a = let x = 1, z
+  
+end
END

test "julia, let, function", <<~END
-let x = f()█
+let x = f()
+  
+end
END

test "julia, let loop, correct indent 1", <<~END
-let i = f(
-    )█
+let i = f(
+    )
+  
+end
END

test "julia, let loop, correct indent 2", <<~END
-let i = 1,
-    j = 2█
+let i = 1,
+    j = 2
+  
+end
END

test "julia, let loop, correct indent 3", <<~END
-let i = 1, j = f(
-    )█
+let i = 1, j = f(
+    )
+  
+end
END

test "julia, let, nested 1", <<~END
-let z
-  let█
-end
+let z
+  let
+    
+  end
+end
END

test "julia, let, nested 2", <<~END
-let x = f(), y, z
-  let a█
-end
+let x = f(), y, z
+  let a
+    
+  end
+end
END

test "julia, let, nested double 1", <<~END
-let x = 1, y, z
-  let
-  end
-  let a, b = 1, c = f()█
-end
+let x = 1, y, z
+  let
+  end
+  let a, b = 1, c = f()
+    
+  end
+end
END

test "julia, let, nested double 2", <<~END
-let x = 1, y, z
-  let a, b = 1, c█
-  let t, u = f(), v = 1
-  end
-end
+let x = 1, y, z
+  let a, b = 1, c
+    
+  end
+  let t, u = f(), v = 1
+  end
+end
END

# broken
# test "julia, let, incomplete", <<~END
# -a = let x
# -  let y = 1, z█
# +a = let x
# +  let y = 1, z
# +    
# +  end
# END

##################################################

test "julia, function, empty function", <<~END
-function f█
+function f
+  
+end
END

test "julia, function, anonymous", <<~END
-function (x, y)█
+function (x, y)
+  
+end
END

test "julia, function, simple", <<~END
-function f()█
+function f()
+  
+end
END

test "julia, function, return type", <<~END
-function foo(x::Any, y::Int)::Int8█
+function foo(x::Any, y::Int)::Int8
+  
+end
END

test "julia, function, parametrized", <<~END
-function (p::P)(x::T) where {T <: Int}█
+function (p::P)(x::T) where {T <: Int}
+  
+end
END

test "julia, function, in module", <<~END
-function M.f()█
+function M.f()
+  
+end
END

test "julia, function, operator overload 1", <<~END
-function Base.:(==)(a, b)█
+function Base.:(==)(a, b)
+  
+end
END

test "julia, function, operator overload 2", <<~END
-function *(a, b)█
+function *(a, b)
+  
+end
END

test "julia, function, nested 1", <<~END
-function foo()::Int8
-  function bar(a::T, b::U) where {T, U}█
-end
+function foo()::Int8
+  function bar(a::T, b::U) where {T, U}
+    
+  end
+end
END

test "julia, function, nested 2", <<~END
-function foo
-  function bar()::Int8█
-end
+function foo
+  function bar()::Int8
+    
+  end
+end
END

test "julia, function, nested double 1", <<~END
-function foo(x, y, z)
-  function q
-  end
-  function bar()::Int8█
-end
+function foo(x, y, z)
+  function q
+  end
+  function bar()::Int8
+    
+  end
+end
END

test "julia, function, nested double 2", <<~END
-function bar(a::T, b::U) where {T, U}
-  function (x, y, z)█
-  function foo()::Int8
-  end
-end
+function bar(a::T, b::U) where {T, U}
+  function (x, y, z)
+    
+  end
+  function foo()::Int8
+  end
+end
END

test "julia, function, incomplete", <<~END
-function f(a, b, c)::Any
-  function ()█
+function f(a, b, c)::Any
+  function ()
+    
+  end
END

##################################################

test "julia, macro, empty macro", <<~END
-macro f█
+macro f
+  
+end
END

test "julia, macro, constant", <<~END
-macro f()█
+macro f()
+  
+end
END

test "julia, macro, arg", <<~END
-macro f(a, b)█
+macro f(a, b)
+  
+end
END

test "julia, macro, nested 1", <<~END
-macro foo()
-  macro bar(a, b)█
-end
+macro foo()
+  macro bar(a, b)
+    
+  end
+end
END

test "julia, macro, nested 2", <<~END
-macro foo(a, b)
-  macro bar()█
-end
+macro foo(a, b)
+  macro bar()
+    
+  end
+end
END

test "julia, macro, nested double 1", <<~END
-macro foo()
-  macro bar
-  end
-  macro baz(a, b)█
-end
+macro foo()
+  macro bar
+  end
+  macro baz(a, b)
+    
+  end
+end
END

test "julia, macro, nested double 2", <<~END
-macro foo(a, b)
-  macro bar()█
-  macro baz
-  end
-end
+macro foo(a, b)
+  macro bar()
+    
+  end
+  macro baz
+  end
+end
END

test "julia, macro, incomplete 1", <<~END
-macro f(a, b, c)
-  macro g█
+macro f(a, b, c)
+  macro g
+    
+  end
END

test "julia, macro, incomplete 2", <<~END
-macro f()
-  macro g(a, b, c)█
+macro f()
+  macro g(a, b, c)
+    
+  end
END

##################################################

test "julia, do, no arg", <<~END
-f(x) do█
+f(x) do
+  
+end
END

test "julia, do, arg", <<~END
-f(1:9) do x█
+f(1:9) do x
+  
+end
END

test "julia, do, args", <<~END
-f(1:9) do x, y█
+f(1:9) do x, y
+  
+end
END

test "julia, do, arg tuple 1", <<~END
-f(1:9) do (x, y)█
+f(1:9) do (x, y)
+  
+end
END

test "julia, do, arg tuple 2", <<~END
-f(1:9) do (x, y), z█
+f(1:9) do (x, y), z
+  
+end
END

test "julia, do, arg tuple 3", <<~END
-f(1:9) do x, (y, z)█
+f(1:9) do x, (y, z)
+  
+end
END

test "julia, do, nested 1", <<~END
-f(x, "a") do (a, b), c
-  f(x, "b") do█
-end
+f(x, "a") do (a, b), c
+  f(x, "b") do
+    
+  end
+end
END

test "julia, do, nested 2", <<~END
-f(1:9) do x
-  f(1:9) do a, (b, c)█
-end
+f(1:9) do x
+  f(1:9) do a, (b, c)
+    
+  end
+end
END

test "julia, do, nested double 1", <<~END
-f(x, "a") do (a, b), c
-  g() do
-  end
-  h(x, "b") do█
-end
+f(x, "a") do (a, b), c
+  g() do
+  end
+  h(x, "b") do
+    
+  end
+end
END

test "julia, do, nested double 2", <<~END
-f(x, "a") do (a, b), c
-  g(x, "b") do█
-  h() do a, (b, c)
-  end
-end
+f(x, "a") do (a, b), c
+  g(x, "b") do
+    
+  end
+  h() do a, (b, c)
+  end
+end
END

test "julia, do, incomplete", <<~END
-f(1:9) do (a, b)
-  f(1:9) do█
+f(1:9) do (a, b)
+  f(1:9) do
+    
+  end
END

################################################## 

test "julia, begin, eof", <<~END
-begin█
+begin
+  
+end
END

test "julia, begin, not eof", <<~END
-begin█
-x = 1
+begin
+  
+end
+x = 1
END

test "julia, begin, assignment indent", <<~end
-f = x -> begin█
+f = x -> begin
+  
+end
end

test "julia, begin, nested 1", <<~END
-f = x -> begin
-  begin█
-end
+f = x -> begin
+  begin
+    
+  end
+end
END

test "julia, begin, nested 2", <<~END
-x = 1
-begin
-  f = x -> begin█
-end
+x = 1
+begin
+  f = x -> begin
+    
+  end
+end
END

test "julia, begin, nested double 1", <<~END
-f = x -> begin
-  begin
-  end
-  begin█
-end
+f = x -> begin
+  begin
+  end
+  begin
+    
+  end
+end
END

test "julia, begin, nested double 2", <<~END
-x = 1
-begin
-  f = x -> begin█
-  g = y -> begin
-  end
-end
+x = 1
+begin
+  f = x -> begin
+    
+  end
+  g = y -> begin
+  end
+end
END
