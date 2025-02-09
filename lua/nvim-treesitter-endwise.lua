local queries = require("nvim-treesitter.query")
local parsers = require('nvim-treesitter.parsers')

local M = {}

function M.init()
    if vim.fn.has('nvim-0.9') == 1 then
        vim.api.nvim_create_autocmd({ 'FileType' }, {
            callback = function(details)
                require('nvim-treesitter.endwise').detach(details.buf)

                local lang = vim.treesitter.language.get_lang(details.match)
                if not M.is_supported(lang) then
                    return
                end

                require('nvim-treesitter.endwise').attach(details.buf)
            end,
        })
        vim.api.nvim_create_autocmd({ 'BufUnload' }, {
            callback = function(details)
                require('nvim-treesitter.endwise').detach(details.buf)
            end,
        })
    else
        require('nvim-treesitter').define_modules {
            endwise = {
                module_path = 'nvim-treesitter.endwise',
                enable = false,
                disable = {},
                is_supported = M.is_supported,
            }
        }
    end
end

function M.is_supported(lang)
    local seen = {}
    local function has_nested_endwise_language(nested_lang)
        if not nested_lang then
            return false
        end

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
end

return M
