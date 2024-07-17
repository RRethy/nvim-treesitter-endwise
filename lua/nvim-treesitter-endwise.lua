local M = {}

function M.setup()
    vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("NvimTreesitter-endwise", {}),
        callback = function(args)
            require("nvim-treesitter-endwise.attachment").reattach_module(args.buf)
        end,
        desc = "Reattach module",
    })
end

return M
