config({
  extension: "ex",
  overrides: <<~INIT_LUA
    vim.opt.expandtab = true
    vim.opt.shiftwidth = 2
    INIT_LUA
})

test "elixir, outside of syntax tree works", <<~END
-█
-
-"foobar"
+
+
+
+"foobar"
END

test "elixir, normal cr works", <<~END
-"foobar"█
+"foobar"
+
END

test "elixir, subtree, basic example works", <<~END
-defmodule Foo do█
+defmodule Foo do
+  
+end
END

test "elixir, subtree", <<~END
-defmodule Foo do█bar
+defmodule Foo do
+  bar
+end
END

test "elixir, subtree, trailing text works as expected", <<~END
-defmodule Foo do█ bar
+defmodule Foo do
+  bar
+end
END

test "elixir, subtree, realizes end belongs to parent", <<~END
-defmodule Foo do
-  def foo do█
-end
+defmodule Foo do
+  def foo do
+    
+  end
+end
END

test "elixir, valid syntax is no-op", <<~END
-defmodule Foo do█
-end
+defmodule Foo do
+
+end
END

test "elixir, one-liner syntax is no-op", <<~END
-def foo, do: :bar█
+def foo, do: :bar
+
END

test "elixir, subtree, module works", <<~END
-defmodule Foo do█
+defmodule Foo do
+  
+end
END

test "elixir, subtree, method works", <<~END
-def foo do█
+def foo do
+  
+end
END

test "elixir, subtree, method with arguments works", <<~END
-def foo(%{bar: bar}) do█
+def foo(%{bar: bar}) do
+  
+end
END

test "elixir, subtree, method with guard works", <<~END
-def foo(bar) when is_function(bar) do█
+def foo(bar) when is_function(bar) do
+  
+end
END

test "elixir, sequence, module works", <<~END
-defmodule Foo do█
-def foo do
-end
+defmodule Foo do
+  
+end
+def foo do
+end
END

test "elixir, sequence, method works", <<~END
-def foo do█
-def foo do
-end
+def foo do
+  
+end
+def foo do
+end
END

test "elixir, defprotocol works", <<~END
-defprotocol Foo.Bar do█
+defprotocol Foo.Bar do
+  
+end
END

test "elixir, defimpl works", <<~END
-defimpl Foo.Bar, for: Baz do█
+defimpl Foo.Bar, for: Baz do
+  
+end
END

test "elixir, unless stmt", <<~END
-unless true do█
+unless true do
+  
+end
END

test "elixir, case stmt", <<~END
-case {:ok, result} do█
+case {:ok, result} do
+  
+end
END

test "elixir, cond stmt", <<~END
-cond do█
+cond do
+  
+end
END

test "elixir, try stmt", <<~END
-try do█
+try do
+  
+end
END
