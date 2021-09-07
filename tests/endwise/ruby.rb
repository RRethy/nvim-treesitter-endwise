config({
  lang: "ruby",
  extension: "rb",
  overrides: <<~INIT_LUA
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
INIT_LUA
})

test <<~END
-"foobar"█
+"foobar"
+█
END

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

test <<~END
-  module Foo█bar
-def foo
-end
+  module Foo
+    █bar
+  end
+def foo
+end
END

test <<~END
-  module Foo█ bar
-def foo
-end
+  module Foo
+    █bar
+  end
+def foo
+end
END

test <<~END
-module Foo█
-def foo
-end
+module Foo
+  █
+end
+def foo
+end
END

# I'm not sure if I want to keep this behaviour of searching up so many lines,
# but for now I like it
test <<~END
-module Foo
-
-█
-def foo
-end
+module Foo
+
+
+  █
+end
+def foo
+end
END

test <<~END
-module Foo█
+module Foo
+  █
+end
END

test <<~END
-module Foo█bar
+module Foo
+  █bar
+end
END

test <<~END
-module Foo█ bar
+module Foo
+  █bar
+end
END

test <<~END
-module Foo
-  def foo█
-end
+module Foo
+  def foo
+    █
+  end
+end
END
