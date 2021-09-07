local M = {}

function M.init()
    require("nvim-treesitter").define_modules {
        endwise = {
            module_path = "nvim-treesitter.endwise",
            enable = false,
            disable = {},
            is_supported = function(lang)
                return lang == 'ruby'
            end,
        }
    }
end

return M
