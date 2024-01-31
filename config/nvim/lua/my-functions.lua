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
-- When leaving a buffer, save the cursor position

vim.cmd([[
au BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

" When entering a buffer, restore the cursor position
function! MyWinSaveView()
        if &diff
                let b:winview = winsaveview()
        endif
endf
function! MyWinRestoreView()
        if &diff
                if(exists('b:winview'))
                        call winrestview(b:winview)
                endif
        endif
endf
au BufLeave * :call MyWinSaveView()
au BufEnter * :call MyWinRestoreView()
]])

---------------------------------------------------------------------------
-- misc bindings

-- ,so - reload configuration
vim.cmd("nnoremap <LocalLeader>so :source $MYVIMRC<CR>")

-- find merge conflict markers
vim.cmd([[
map <LocalLeader>fc /\v^[<\|=>]{7}( .*\|$)<CR>
]])
