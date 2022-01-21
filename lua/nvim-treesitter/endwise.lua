local parsers = require("nvim-treesitter.parsers")
local queries = require("nvim-treesitter.query")
local ts_utils = require("nvim-treesitter.ts_utils")

local M = {}
local indent_regex = vim.regex("\\v^\\s*\\zs\\S")
local tracking = {}

local function in_range(row, col, start_range, end_range)
    end_range = end_range or start_range
    return not (row < start_range[1] or row == start_range[1] and col < start_range[2]
        or row > end_range[3] or row == end_range[3] and col >= end_range[4])
end

local function tabstr()
    if vim.bo.expandtab then
        return string.rep(" ", vim.fn.shiftwidth())
    else
        return "	"
    end
end

local function strip_leading_whitespace(line)
    local indent_end = indent_regex:match_str(line)
    if indent_end then
        local indentation = string.sub(line, 0, indent_end)
        local text = string.sub(line, indent_end + 1)
        return indentation, text
    else
        return line, ""
    end
end

local function lacks_end(node, end_text)
    local end_node = node:child(node:child_count()-1)
    if end_node:type() ~= end_text then
        return false
    end
    if end_node:missing() then
        return true
    end

    local node_range = {node:range()}
    local indentation = strip_leading_whitespace(vim.fn.getline(node_range[1] + 1))
    local end_node_range = {end_node:range()}
    local end_node_indentation = strip_leading_whitespace(vim.fn.getline(end_node_range[1] + 1))
    if indentation == end_node_indentation then
        return false
    end

    local parent = node:parent()
    while parent ~= nil do
        if parent:has_error() then
            return true
        end
        parent = parent:parent()
    end
    return false
end

local function add_end_node(indent_node_range, end_text)
    local crow, ccol = unpack(vim.api.nvim_win_get_cursor(0))
    local indentation = strip_leading_whitespace(vim.fn.getline(indent_node_range[1] + 1))
    vim.fn.append(crow, indentation..end_text)

    local line = vim.fn.getline(crow)
    local trailing_text = string.sub(line, ccol + 1)
    local _, text = strip_leading_whitespace(trailing_text)
    local line_indentation = indentation..tabstr()
    vim.fn.setline(crow, line_indentation..text)
    vim.fn.cursor(crow, #line_indentation + 1)
end

local function endwise(bufnr)
    local lang = parsers.get_buf_lang(bufnr)
    if not lang then
        return
    end

    local row, col = unpack(vim.fn.searchpos("\\S", "nbW"))
    row = row - 1
    col = col - 1

    local root_lang_tree = parsers.get_parser(bufnr)
    local root = ts_utils.get_root_for_position(row, col, root_lang_tree)
    if not root then
        return
    end
    local query = queries.get_query(lang, "endwise")
    local range = {root:range()}

    for _, match, metadata in query:iter_matches(root, bufnr, range[1], range[3] + 1) do
        local end_text = metadata.endwise_end

        if metadata.annotations == "subtree" then
            local node = match[1]
            local node_range = {node:range()}
            if in_range(row, col, node_range) then
                if lacks_end(node, end_text) then
                    add_end_node(node_range, end_text)
                    return
                end
            end
        elseif metadata.annotations == "sequence" then
            local indent_node, tail_node
            for id, node in pairs(match) do
                if query.captures[id] == "indent" then
                    indent_node = node
                elseif query.captures[id] == "tail" then
                    tail_node = node
                end
            end
            local indent_node_range = {indent_node:range()}
            local tail_node_range = {tail_node:range()}
            if in_range(row, col, indent_node_range, tail_node_range) then
                add_end_node(indent_node_range, end_text)
                return
            end
        end
    end
end

vim.treesitter.query.add_directive("annotate!", function(_, _, _, predicate, metadata)
    metadata.annotations = predicate[2]
end)

vim.treesitter.query.add_directive("endwise-end!", function(_, _, _, predicate, metadata)
    metadata.endwise_end = predicate[2]
end)

vim.on_key(function(key)
    if vim.fn.char2nr(key) ~= 13 then return end
    if vim.fn.mode() ~= "i" then return end
    local bufnr = vim.fn.bufnr()
    if not tracking[bufnr] then return end
    vim.schedule_wrap(function()
        vim.cmd("doautocmd User PreNvimTreesitterEndwiseCR")
        endwise(bufnr)
        vim.cmd("doautocmd User PostNvimTreesitterEndwiseCR")
    end)()
end, nil)

function M.attach(bufnr)
    tracking[bufnr] = true
end

function M.detach(bufnr)
    tracking[bufnr] = false
end

return M
