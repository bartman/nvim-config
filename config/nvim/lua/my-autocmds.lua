local vim = vim

---------------------------------------------------------------------------
-- force ft=help for .txt files in what looks like nvim doc directories

-- autocmd BufEnter,BufNewFile,BufRead * if @% =~ '.*local/share/nvim/.*/.*/doc/.*\.txt$' | set ft=help | endif

vim.api.nvim_create_autocmd({ "BufEnter", "BufNewFile", "BufRead" }, {
    pattern = "*",
    callback = function()
        -- Check if the current file's path matches the specific pattern
        if vim.fn.expand("%"):match(".*/local/share/nvim/.*/.*/doc/.*%.txt$") then
            vim.bo.filetype = "help"
        end
    end,
})

---------------------------------------------------------------------------
-- When leaving a buffer, save the cursor position, restore on reentry

vim.api.nvim_create_autocmd({ "BufRead", "BufReadPost" }, {
    callback = function()
        local buffer_name = vim.api.nvim_buf_get_name(0)
        if #buffer_name == 0 then
            return
        end -- skip buffer with no name

        local filetype = vim.api.nvim_get_option_value("filetype", { scope = "local" })
        if filetype == "neo-tree" then
            return
        end

        local row, column = unpack(vim.api.nvim_buf_get_mark(0, '"'))
        local buf_line_count = vim.api.nvim_buf_line_count(0)

        if row >= 1 and row <= buf_line_count then -- only within range
            vim.api.nvim_win_set_cursor(0, { row, column })
        end
    end,
})

---------------------------------------------------------------------------
-- :copen will open full width of the screen, by being pushed down to the bottom

-- autocmd filetype qf wincmd J

vim.api.nvim_create_autocmd("FileType", {
    pattern = "qf",
    command = "wincmd J",
})

---------------------------------------------------------------------------
-- when opening a terminal, disable spell checking

vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "*",
    callback = function()
        vim.opt_local.spell = false
    end,
})

---------------------------------------------------------------------------
-- when in diff mode, disable spell checking

vim.api.nvim_create_autocmd({"BufWinEnter", "WinNew", "BufReadPost", "WinEnter"}, {
    pattern = "*",
    callback = function()
        if vim.wo.diff and vim.wo.spell then
            vim.wo.spell = false
        end
    end,
})

