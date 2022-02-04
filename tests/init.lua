vim.opt.runtimepath:append('.')
vim.opt.runtimepath:append('../nvim-treesitter')
vim.opt.runtimepath:append('../playground')
require('nvim-treesitter.configs').setup {
    playground = {
        enable = true,
    },
    endwise = {
        enable = true,
    },
}

function ExecuteCR(n)
    vim.schedule_wrap(function()
    local keys = vim.api.nvim_replace_termcodes(string.rep('l', n)..'a<CR>', true, false, true)
    vim.cmd([[ autocmd User PostNvimTreesitterEndwiseCR lua vim.cmd('wq') ]])
    vim.fn.feedkeys(keys, 'n')
    end)()
end
