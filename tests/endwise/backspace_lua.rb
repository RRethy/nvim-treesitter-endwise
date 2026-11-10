config({
  extension: "lua",
  command: "ExecuteBS",
  overrides: <<~INIT_LUA
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
INIT_LUA
})

test "lua, backspace removes inline end without following space", <<~END
-foo(function() █end)
+foo(function())
END

test "lua, backspace removes inline end with following space", <<~END
-foo(function() █ end)
+foo(function())
END

test "lua, backspace collapses empty multiline end", <<~END
-foo(function()
-  █
-end)
+foo(function()  end)
END
