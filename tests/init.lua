vim.opt.runtimepath:append('.')
vim.opt.showmode = false

local function feedkeys(input)
    local keys = vim.api.nvim_replace_termcodes(input, true, false, true)
    vim.fn.feedkeys(keys, 'n')
end

function ExecuteCR(n)
    vim.schedule(function ()
        vim.api.nvim_create_autocmd('User', {
            pattern = 'PostNvimTreesitterEndwiseCR',
            command = "silent wq"
        })
        feedkeys(string.rep('l', n)..'a<CR>')
    end)
end

function ExecuteSpace(n)
    vim.schedule(function()
        local expected_cursor = { vim.api.nvim_win_get_cursor(0)[1], n + 2 }
        vim.defer_fn(function() vim.cmd('cquit 1') end, 5000)
        vim.api.nvim_create_autocmd('User', {
            pattern = 'PostNvimTreesitterEndwiseCR',
            callback = function()
                if not vim.deep_equal(vim.api.nvim_win_get_cursor(0), expected_cursor) then
                    io.stderr:write('Space completion moved the insertion cursor')
                    vim.cmd('cquit 1')
                    return
                end
                if vim.bo.filetype == 'lua' then
                    local _, err = loadstring(table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), '\n'))
                    if err then
                        io.stderr:write(err)
                        vim.cmd('cquit 1')
                        return
                    end
                end
                vim.cmd('silent wq')
            end,
        })
        feedkeys(string.rep('l', n)..'a<Space>')
    end)
end

function ExecuteCRTwiceAndUndo(n)
    local call_count = 0
    local post_endwise_cb = function()
        call_count = call_count + 1

        if call_count < 2 then
            feedkeys('<CR>')
        else
            vim.cmd([[ silent undo | silent wq ]])
        end
    end

    vim.schedule(function ()
        vim.api.nvim_create_autocmd('User', {
            pattern = 'PostNvimTreesitterEndwiseCR',
            callback = post_endwise_cb
        })
        feedkeys(string.rep('l', n)..'a<CR>')
    end)
end
