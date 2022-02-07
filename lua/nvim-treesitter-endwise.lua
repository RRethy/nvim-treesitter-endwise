local queries = require("nvim-treesitter.query")
local parsers = require('nvim-treesitter.parsers')

local M = {}

function M.init()
    require('nvim-treesitter').define_modules {
        endwise = {
            module_path = 'nvim-treesitter.endwise',
            enable = false,
            disable = {},
            is_supported = function(lang)
                local seen = {}
                local function has_nested_endwise_language(nested_lang)
                    if not parsers.has_parser(nested_lang) then
                        return false
                    end
                    if queries.has_query_files(nested_lang, 'endwise') then
                        return true
                    end
                    if seen[nested_lang] then
                        return false
                    end
                    seen[nested_lang] = true

                    if queries.has_query_files(nested_lang, 'injections') then
                        local query = queries.get_query(nested_lang, 'injections')
                        for _, capture in ipairs(query.info.captures) do
                            if capture == 'language' or has_nested_endwise_language(capture) then
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
