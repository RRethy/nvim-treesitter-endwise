config({
  extension: "cr",
  overrides: <<~INIT_LUA
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
INIT_LUA
})

# ===== Basic functionality tests =====

test "crystal, outside of syntax tree works", <<~END
-█
-
-"foobar"
+
+
+
+"foobar"
END

test "crystal, normal cr works", <<~END
-"foobar"█
+"foobar"
+
END

# ===== Module =====

test "crystal, module basic", <<~END
-module Foo█
+module Foo
+  
+end
END

test "crystal, module nested", <<~END
-module Foo
-  module Bar█
-end
+module Foo
+  module Bar
+    
+  end
+end
END

test "crystal, module sequence", <<~END
-module Foo█
-def bar
-end
+module Foo
+  
+end
+def bar
+end
END

# ===== Class =====

test "crystal, class basic", <<~END
-class Foo█
+class Foo
+  
+end
END

test "crystal, class with superclass", <<~END
-class Foo < Bar█
+class Foo < Bar
+  
+end
END

test "crystal, class nested", <<~END
-class Foo
-  class Bar█
-end
+class Foo
+  class Bar
+    
+  end
+end
END

test "crystal, class sequence", <<~END
-class Foo█
-def bar
-end
+class Foo
+  
+end
+def bar
+end
END

# ===== Struct =====

test "crystal, struct basic", <<~END
-struct Foo█
+struct Foo
+  
+end
END

test "crystal, struct with superclass", <<~END
-struct Foo < Bar█
+struct Foo < Bar
+  
+end
END

test "crystal, struct nested", <<~END
-class Foo
-  struct Bar█
-end
+class Foo
+  struct Bar
+    
+  end
+end
END

# ===== Enum =====

test "crystal, enum basic", <<~END
-enum Color█
+enum Color
+  
+end
END

test "crystal, enum nested", <<~END
-module Foo
-  enum Color█
-end
+module Foo
+  enum Color
+    
+  end
+end
END

# ===== Lib (FFI) =====

test "crystal, lib basic", <<~END
-lib LibC█
+lib LibC
+  
+end
END

# ===== Annotation =====

test "crystal, annotation basic", <<~END
-annotation MyAnnotation█
+annotation MyAnnotation
+  
+end
END

# ===== Method (def) =====

test "crystal, def basic", <<~END
-def foo█
+def foo
+  
+end
END

test "crystal, def with params", <<~END
-def foo(bar, baz)█
+def foo(bar, baz)
+  
+end
END

test "crystal, def with return type", <<~END
-def foo : String█
+def foo : String
+  
+end
END

test "crystal, def nested", <<~END
-class Foo
-  def bar█
-end
+class Foo
+  def bar
+    
+  end
+end
END

test "crystal, def sequence", <<~END
-def foo█
-def bar
-end
+def foo
+  
+end
+def bar
+end
END

test "crystal, def class method", <<~END
-def self.foo█
+def self.foo
+  
+end
END

# ===== Macro =====

test "crystal, macro basic", <<~END
-macro foo█
+macro foo
+  
+end
END

test "crystal, macro with params", <<~END
-macro foo(bar, baz)█
+macro foo(bar, baz)
+  
+end
END

test "crystal, macro nested in class", <<~END
-class Foo
-  macro bar█
-end
+class Foo
+  macro bar
+    
+  end
+end
END

# ===== Control Flow: if =====

test "crystal, if basic", <<~END
-if true█
+if true
+  
+end
END

test "crystal, if with condition", <<~END
-if foo > 0█
+if foo > 0
+  
+end
END

test "crystal, if nested", <<~END
-if true
-  if false█
-end
+if true
+  if false
+    
+  end
+end
END

test "crystal, if sequence", <<~END
-if true█
-def foo
-end
+if true
+  
+end
+def foo
+end
END

# ===== Control Flow: unless =====

test "crystal, unless basic", <<~END
-unless false█
+unless false
+  
+end
END

test "crystal, unless nested", <<~END
-unless true
-  unless false█
-end
+unless true
+  unless false
+    
+  end
+end
END

# ===== Control Flow: while =====

test "crystal, while basic", <<~END
-while true█
+while true
+  
+end
END

test "crystal, while nested", <<~END
-while true
-  while false█
-end
+while true
+  while false
+    
+  end
+end
END

# ===== Control Flow: until =====

test "crystal, until basic", <<~END
-until false█
+until false
+  
+end
END

test "crystal, until nested", <<~END
-until false
-  until true█
-end
+until false
+  until true
+    
+  end
+end
END

# ===== Control Flow: case =====

test "crystal, case basic", <<~END
-case foo█
+case foo
+  
+end
END

test "crystal, case nested", <<~END
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

# ===== Blocks: do...end =====

test "crystal, do block basic", <<~END
-foo.each do█
+foo.each do
+  
+end
END

test "crystal, do block with param", <<~END
-foo.each do |x|█
+foo.each do |x|
+  
+end
END

test "crystal, do block with multiple params", <<~END
-foo.each do |k, v|█
+foo.each do |k, v|
+  
+end
END

test "crystal, do block nested", <<~END
-foo.each do |x|
-  bar.each do |y|█
-end
+foo.each do |x|
+  bar.each do |y|
+    
+  end
+end
END

# ===== Blocks: begin...end =====

test "crystal, begin basic", <<~END
-begin█
+begin
+  
+end
END

test "crystal, begin nested", <<~END
-begin
-  begin█
-end
+begin
+  begin
+    
+  end
+end
END

# ===== Complex nested scenarios =====

test "crystal, deeply nested class and method", <<~END
-module Foo
-  class Bar
-    def baz█
-  end
-end
+module Foo
+  class Bar
+    def baz
+      
+    end
+  end
+end
END

test "crystal, method with if inside", <<~END
-def foo
-  if true█
-end
+def foo
+  if true
+    
+  end
+end
END

# ===== Valid syntax should be no-op =====
# Note: endwise does not add 'end' when structure is already complete
# Cursor indentation is vim's responsibility, not endwise

test "crystal, valid module is no-op", <<~END
-module Foo█
-end
+module Foo
+
+end
END

test "crystal, valid class is no-op", <<~END
-class Foo█
-end
+class Foo
+
+end
END

test "crystal, valid def is no-op", <<~END
-def foo█
-end
+def foo
+
+end
END

# ===== Indentation tests =====

test "crystal, indented module", <<~END
-  module Foo█
-def bar
-end
+  module Foo
+    
+  end
+def bar
+end
END

# ===== Trailing text handling =====

test "crystal, trailing text on module", <<~END
-module Foo█bar
+module Foo
+  bar
+end
END

test "crystal, trailing text on def", <<~END
-def foo█bar
+def foo
+  bar
+end
END

test "crystal, trailing text with leading space", <<~END
-module Foo█ bar
+module Foo
+  bar
+end
END

# ===== Crystal-specific: abstract classes =====

test "crystal, abstract class", <<~END
-abstract class Foo█
+abstract class Foo
+  
+end
END

test "crystal, abstract struct", <<~END
-abstract struct Foo█
+abstract struct Foo
+  
+end
END

# ===== Crystal-specific: visibility =====

test "crystal, private def", <<~END
-private def foo█
+private def foo
+  
+end
END

test "crystal, protected def", <<~END
-protected def foo█
+protected def foo
+  
+end
END

# ===== Edge cases =====

test "crystal, realizes end belongs to parent", <<~END
-module Foo
-  def bar█
-end
+module Foo
+  def bar
+    
+  end
+end
END

test "crystal, struct in module", <<~END
-module Foo
-  struct Point█
-end
+module Foo
+  struct Point
+    
+  end
+end
END

test "crystal, enum in class", <<~END
-class Foo
-  enum Status█
-end
+class Foo
+  enum Status
+    
+  end
+end
END
