config({
  extension: "rb",
  overrides: <<~INIT_LUA
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
INIT_LUA
})

test "2 spaces works", <<~END
-  module Foo█
-def foo
-end
+  module Foo
+    
+  end
+def foo
+end
END

config({
  extension: "rb",
  overrides: <<~INIT_LUA
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
INIT_LUA
})

test "4 spaces works", <<~END
-    module Foo█
-def foo
-end
+    module Foo
+        
+    end
+def foo
+end
END

config({
  extension: "rb",
  overrides: <<~INIT_LUA
vim.opt.expandtab = false
vim.opt.shiftwidth = 2
INIT_LUA
})

test "tabs works", <<~END
-	module Foo█
-def foo
-end
+	module Foo
+		
+	end
+def foo
+end
END
