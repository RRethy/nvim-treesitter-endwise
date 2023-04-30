config({
  extension: "rb",
  command: 'ExecuteCRTwiceAndUndo',
  overrides: <<~INIT_LUA
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
INIT_LUA
})

test "ruby, undo, clean undo-block after multiple <CR>s before end of file", <<~END
-def foo█
-
+def foo
+
END

test "ruby, undo, clean undo-block after multiple <CR>s at end of file", <<~END
-
-def foo█
+
+def foo
END

config({
  extension: "lua",
  command: 'ExecuteCRTwiceAndUndo',
  overrides: <<~INIT_LUA
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
INIT_LUA
})

test "lua, undo, clean undo-block after multiple <CR>s before end of file", <<~END
-function foo()█
-
+function foo()
+
END

test "lua, undo, clean undo-block after multiple <CR>s at end of file", <<~END
-
-function foo()█
+
+function foo()
END
