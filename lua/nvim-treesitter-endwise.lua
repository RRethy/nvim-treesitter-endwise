local queries = require("nvim-treesitter.query")

local M = {}

function M.init()
    require('nvim-treesitter').define_modules {
        endwise = {
            module_path = 'nvim-treesitter.endwise',
            enable = false,
            disable = {},
            is_supported = function(lang)
                if queries.has_query_files(lang, 'endwise') then
                    return true
                end

                local seen = {}
                local function has_nested_endwise_language(nested_lang)
                    if seen[nested_lang] then
                        return false
                    end
                    seen[nested_lang] = true

                    if queries.has_query_files(lang, 'injections') then
                        local query = queries.get_query(lang, 'injections')
                        for _, capture in ipairs(query.info.captures) do
                            if capture == 'language'
                                or queries.has_query_files(lang, 'endwise')
                                or has_nested_endwise_language(lang) then
                                return true
                            end
                        end
                    end

                    return false
                end

                return has_nested_endwise_language(lang)
            end,
        }
    }
end

return M
