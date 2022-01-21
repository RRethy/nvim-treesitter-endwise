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
    local keys = vim.api.nvim_replace_termcodes(string.rep('l', n)..'a<CR>a<Esc>x', true, false, true)
    vim.fn.feedkeys(keys, 'mi')
    vim.cmd([[ autocmd User PostNvimTreesitterEndwiseCR lua vim.cmd('wq') ]])
end
