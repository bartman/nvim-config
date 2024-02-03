---------------------------------------------------------------------------
-- force ft=help for .txt files in what looks like nvim doc directories

vim.cmd([[
autocmd BufEnter,BufNewFile,BufRead * if @% =~ '.*local/share/nvim/.*/.*/doc/.*\.txt$' | set ft=help | endif
]])

---------------------------------------------------------------------------
-- :A

local function alternate_file()
    local current_file = vim.api.nvim_buf_get_name(0)
    local alternate_file

    if string.match(current_file, "%.cpp$") then
        alternate_file = string.gsub(current_file, "%.cpp$", ".hpp")
    elseif string.match(current_file, "%.hpp$") then
        alternate_file = string.gsub(current_file, "%.hpp$", ".cpp")
    elseif string.match(current_file, "%.c$") then
        alternate_file = string.gsub(current_file, "%.c$", ".h")
    elseif string.match(current_file, "%.h$") then
        alternate_file = string.gsub(current_file, "%.h$", ".c")
    else
        print("Not a C/C++ source or header file")
        return
    end

    -- Check if the alternate file exists
    local f = io.open(alternate_file, "r")
    if f then
        io.close(f)
        vim.api.nvim_command('edit ' .. alternate_file)
    else
        print("Alternate file does not exist: " .. alternate_file)
    end
end
vim.api.nvim_create_user_command('A', alternate_file, {})

---------------------------------------------------------------------------
-- When leaving a buffer, save the cursor position, restore on reentry

local api = vim.api
api.nvim_create_autocmd({ 'BufRead', 'BufReadPost' }, {
    callback = function()
        local buffer_name = vim.api.nvim_buf_get_name(0)
        if #buffer_name == 0 then return end -- skip buffer with no name

        local filetype = vim.api.nvim_get_option_value('filetype',{ scope='local' })
        if filetype == 'neo-tree' then return end

        local row, column = unpack(api.nvim_buf_get_mark(0, '"'))
        local buf_line_count = api.nvim_buf_line_count(0)

        if row >= 1 and row <= buf_line_count then -- only within range
            api.nvim_win_set_cursor(0, { row, column })
        end
    end,
})

---------------------------------------------------------------------------
-- misc bindings

-- ,so - reload configuration
vim.cmd("nnoremap <LocalLeader>so :source $MYVIMRC<CR>")

-- find merge conflict markers
vim.cmd([[
map <LocalLeader>fc /\v^[<\|=>]{7}( .*\|$)<CR>
]])
