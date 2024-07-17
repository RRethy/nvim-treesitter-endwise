local queries = require("nvim-treesitter.query")
local parsers = require("nvim-treesitter.parsers")

local attached_buffers = {}

local M = {}

local function is_supported(lang)
    local seen = {}
    local function has_nested_endwise_language(nested_lang)
        if not parsers.has_parser(nested_lang) then
            return false
        end
        if queries.has_query_files(nested_lang, "endwise") then
            return true
        end
        if seen[nested_lang] then
            return false
        end
        seen[nested_lang] = true

        if queries.has_query_files(nested_lang, "injections") then
            local query = queries.get_query(nested_lang, "injections")
            for _, capture in ipairs(query.info.captures) do
                if capture == "language" or has_nested_endwise_language(capture) then
                    return true
                end
            end
        end

        return false
    end

    return has_nested_endwise_language(lang)
end

---Attaches a module to a buffer
---@param bufnr integer the buffer
---@param lang string the language of the buffer
function M.attach_module(bufnr, lang)
    bufnr = bufnr or vim.api.nvim_get_current_buf()
    lang = lang or parsers.get_buf_lang(bufnr)
    local resolved_mod = require("nvim-treesitter-endwise.module")

    if resolved_mod and not vim.tbl_contains(attached_buffers, bufnr) and is_supported(lang) then
        table.insert(attached_buffers, bufnr)
        resolved_mod.attach(bufnr, lang)
    end
end

-- Detaches a module to a buffer
---@param bufnr integer the buffer
function M.detach_module(bufnr)
    local resolved_mod = require("nvim-treesitter-endwise.module")
    bufnr = bufnr or vim.api.nvim_get_current_buf()

    if resolved_mod and vim.tbl_contains(attached_buffers, bufnr) then
        attached_buffers = vim.tbl_filter(function(x)
            return x ~= bufnr
        end, attached_buffers)
        resolved_mod.detach(bufnr)
    end
end

-- Same as attach_module, but if the module is already attached, detach it first.
---@param bufnr integer the buffer
---@param lang string the language of the buffer
function M.reattach_module(bufnr, lang)
    M.detach_module(bufnr)
    M.attach_module(bufnr, lang)
end

return M
