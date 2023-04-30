local parsers = require('nvim-treesitter.parsers')
local queries = require('nvim-treesitter.query')
local ts_utils = require('nvim-treesitter.ts_utils')

local M = {}
local indent_regex = vim.regex('\\v^\\s*\\zs\\S')
local tracking = {}

local function tabstr()
    if vim.bo.expandtab then
        return string.rep(" ", vim.fn.shiftwidth())
    else
        return "	"
    end
end

local function text_for_range(range)
    local srow, scol, erow, ecol = unpack(range)
    if srow == erow then
        return string.sub(vim.fn.getline(srow + 1), scol + 1, ecol)
    else
        return string.sub(vim.fn.getline(srow + 1), scol + 1, -1) .. string.sub(vim.fn.getline(erow + 1), 1, ecol)
    end
end

local function point_in_range(row, col, range)
    return not (row < range[1] or row == range[1] and col < range[2]
        or row > range[3] or row == range[3] and col >= range[4])
end

local function strip_leading_whitespace(line)
    local indent_end = indent_regex:match_str(line)
    if indent_end then
        local indentation = string.sub(line, 0, indent_end)
        local text = string.sub(line, indent_end + 1)
        return indentation, text
    else
        return line, ''
    end
end

local function lacks_end(node, end_text)
    local end_node = node:child(node:child_count() - 1)
    if end_node == nil then
        return true
    end
    if end_node:type() ~= end_text then
        return false
    end
    if end_node:missing() then
        return true
    end

    local node_range = { node:range() }
    local indentation = strip_leading_whitespace(vim.fn.getline(node_range[1] + 1))
    local end_node_range = { end_node:range() }
    local end_node_indentation = strip_leading_whitespace(vim.fn.getline(end_node_range[1] + 1))
    local crow = unpack(vim.api.nvim_win_get_cursor(0))
    if indentation == end_node_indentation or end_node_range[3] == crow - 1 then
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

local function add_end_node(indent_node_range, endable_node_range, end_text, shiftcount)
    local crow = unpack(vim.api.nvim_win_get_cursor(0))
    local indentation = strip_leading_whitespace(vim.fn.getline(indent_node_range[1] + 1))

    local line = vim.fn.getline(crow)
    local trailing_cursor_text, trailing_end_text
    if endable_node_range == nil or crow - 1 < endable_node_range[3] then
        local _, trailing_text = strip_leading_whitespace(line)
        if string.match(trailing_text, "^[%a%d]") then
            trailing_cursor_text = trailing_text
            trailing_end_text = ""
        else
            trailing_end_text = trailing_text
            trailing_cursor_text = ""
        end
    elseif crow - 1 == endable_node_range[3] then
        _, trailing_cursor_text = strip_leading_whitespace(string.sub(line, 1, endable_node_range[4]))
        _, trailing_end_text = strip_leading_whitespace(string.sub(line, endable_node_range[4] + 1, -1))
    else
        trailing_cursor_text = ""
        _, trailing_end_text = strip_leading_whitespace(line)
    end

    local cursor_indentation = indentation .. string.rep(tabstr(), shiftcount)

    vim.fn.setline(crow, cursor_indentation .. trailing_cursor_text)
    vim.fn.append(crow, indentation .. end_text .. trailing_end_text)
    vim.fn.cursor(crow, #cursor_indentation + 1)
end

local function endwise(bufnr)
    local lang = parsers.get_buf_lang(bufnr)
    if not lang then
        return
    end

    if not parsers.has_parser(lang) then
        return
    end

    -- Search up the first the closest non-whitespace text before the cursor
    local row, col = unpack(vim.fn.searchpos('\\S', 'nbW'))
    row = row - 1
    col = col - 1

    local lang_tree = parsers.get_parser(bufnr):language_for_range({ row, col, row, col })
    lang = lang_tree:lang()
    if not lang then
        return
    end

    local root = ts_utils.get_root_for_position(row, col, lang_tree)
    if not root then
        return
    end

    local query = queries.get_query(lang, 'endwise')
    if not query then
        return
    end

    local range = { root:range() }

    for _, match, metadata in query:iter_matches(root, bufnr, range[1], range[3] + 1) do
        local indent_node, cursor_node, endable_node
        for id, node in pairs(match) do
            if query.captures[id] == 'indent' then
                indent_node = node
            elseif query.captures[id] == 'cursor' then
                cursor_node = node
            elseif query.captures[id] == 'endable' then
                endable_node = node
            end
        end

        local indent_node_range = { indent_node:range() }
        local cursor_node_range = { cursor_node:range() }
        if point_in_range(row, col, cursor_node_range) then
            local end_node_type = metadata.endwise_end_node_type or metadata.endwise_end_text
            if not endable_node or lacks_end(endable_node, end_node_type) then
                local end_text = metadata.endwise_end_text
                if metadata.endwise_end_suffix then
                    local suffix = text_for_range({ metadata.endwise_end_suffix:range() })
                    local s, e = vim.regex(metadata.endwise_end_suffix_pattern):match_str(suffix)
                    if s then
                        suffix = string.sub(suffix, s + 1, e)
                    end
                    end_text = end_text .. suffix
                end
                local endable_node_range = endable_node and { endable_node:range() } or nil
                add_end_node(indent_node_range, endable_node_range, end_text, metadata.endwise_shiftcount)
                return
            end
        end
    end
end

-- #endwise! tree-sitter directive
-- @param endwise_end_text string end text to add
-- @param endwise_end_suffix node|nil captured node that contains text to add
--  as a suffix to the end text. E.g. In vimscript, `func` will be ended with
--  `endfunc` and `function` will be ended with `endfunction` even though they
--  are parsed the same. nil to always use endwise_end_text.
-- @param endwise_end_node_type string|nil node type to check against the last
--  child of the @endable captured node. This is required because the
--  endwise_end_text won't match the nodetype if it's dynamic for langauges like
--  vimscript. nil to use endwise_end_text as the node type.
-- @param endwise_shiftcount number a non-negative number of shifts to indent with,
--  defaults to 1
-- @param endwise_end_suffix_pattern string regex pattern to apply onto
--  endwise_end_suffix, defaults to matching the whole string
vim.treesitter.query.add_directive('endwise!', function(match, _, _, predicate, metadata)
    metadata.endwise_end_text = predicate[2]
    metadata.endwise_end_suffix = match[predicate[3]]
    metadata.endwise_end_node_type = predicate[4]
    metadata.endwise_shiftcount = predicate[5] or 1
    metadata.endwise_end_suffix_pattern = predicate[6] or '^.*$'
end)

vim.on_key(function(key)
    if key ~= "\r" then return end
    if vim.api.nvim_get_mode().mode ~= 'i' then return end
    vim.schedule_wrap(function()
        local bufnr = vim.fn.bufnr()
        if not tracking[bufnr] then return end
        vim.cmd('doautocmd User PreNvimTreesitterEndwiseCR') -- Not currently used
        endwise(bufnr)
        vim.cmd('doautocmd User PostNvimTreesitterEndwiseCR') -- Used in tests to know when to exit Neovim
    end)()
end, nil)

function M.attach(bufnr)
    tracking[bufnr] = true
end

function M.detach(bufnr)
    tracking[bufnr] = false
end

return M
