vim.opt.runtimepath:append('.')
vim.opt.runtimepath:append('../nvim-treesitter')
require("nvim-treesitter.configs").setup {
    endwise = {
        enable = true,
    },
}

function ExecuteCR()
    vim.fn.search('█')
    local keys = vim.api.nvim_replace_termcodes("s<CR><C-R>-<Esc>", true, false, true)
    vim.fn.feedkeys(keys, "m")
    vim.schedule_wrap(function() vim.cmd("wq") end)()
end
