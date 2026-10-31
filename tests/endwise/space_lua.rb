config({
  extension: "lua",
  command: "ExecuteSpace",
  overrides: <<~INIT_LUA
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
INIT_LUA
})

test "lua, space, standalone function", <<~END
-function foo()█
+function foo()  end
END

test "lua, space, function call suffix", <<~END
-foo(function()█)
+foo(function()  end)
END

test "lua, space, nested function call suffixes", <<~END
-foo(vim.schedule_wrap(function()█))
+foo(vim.schedule_wrap(function()  end))
END

test "lua, space, table constructor suffix", <<~END
-local callbacks = { function()█ }
+local callbacks = { function()  end }
END

test "lua, space, table field and function call suffixes", <<~END
-setup({ callback = function()█ })
+setup({ callback = function()  end })
END

test "lua, space, preserve existing function body", <<~END
-foo(function()█print('x'))
+foo(function() print('x') end)
END

test "lua, space, preserve parenthesis in string", <<~END
-foo(function()█print(')'))
+foo(function() print(')') end)
END

test "lua, space, preserve multibyte function body", <<~END
-foo(function()█print('你好'))
+foo(function() print('你好') end)
END

test "lua, space, preserve trailing comment after call", <<~END
-foo(function()█) -- comment
+foo(function()  end) -- comment
END

test "lua, space, already terminated function", <<~END
-foo(function()█ end)
+foo(function()  end)
END

test "lua, space, conditional with inline body", <<~END
-if true then█print('x')
+if true then print('x') end
END

test "lua, space, ordinary non-matching position", <<~END
-local value = 1█
+local value = 1#{' '}
END
