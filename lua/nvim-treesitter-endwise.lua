local queries = require("nvim-treesitter.query")

local M = {}

function M.init()
    require('nvim-treesitter').define_modules {
        endwise = {
            module_path = 'nvim-treesitter.endwise',
            enable = false,
            disable = {},
            is_supported = function(lang)
                return queries.has_query_files(lang, 'endwise')
            end,
        }
    }
end

return M
