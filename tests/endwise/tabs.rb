config({
  extension: "rb",
  overrides: <<~INIT_LUA
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
INIT_LUA
})

test <<~END
-  module Foo█
-def foo
-end
+  module Foo
+    █
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

test <<~END
-    module Foo█
-def foo
-end
+    module Foo
+        █
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

test <<~END
-	module Foo█
-def foo
-end
+	module Foo
+		█
+	end
+def foo
+end
END
