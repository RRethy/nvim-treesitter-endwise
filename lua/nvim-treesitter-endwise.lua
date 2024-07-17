local M = {}

function M.setup()
    vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("NvimTreesitter-endwise", {}),
        callback = function(args)
            require("nvim-treesitter-endwise.module").detach(args.buf)
            require("nvim-treesitter-endwise.module").attach(args.buf)
        end,
        desc = "Reattach module",
    })
end

return M
