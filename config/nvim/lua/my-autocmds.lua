local api = vim.api

---------------------------------------------------------------------------
-- force ft=help for .txt files in what looks like nvim doc directories

-- autocmd BufEnter,BufNewFile,BufRead * if @% =~ '.*local/share/nvim/.*/.*/doc/.*\.txt$' | set ft=help | endif

api.nvim_create_autocmd({ "BufEnter", "BufNewFile", "BufRead" }, {
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

api.nvim_create_autocmd({ "BufRead", "BufReadPost" }, {
    callback = function()
        local buffer_name = api.nvim_buf_get_name(0)
        if #buffer_name == 0 then
            return
        end -- skip buffer with no name

        local filetype = api.nvim_get_option_value("filetype", { scope = "local" })
        if filetype == "neo-tree" then
            return
        end

        local row, column = unpack(api.nvim_buf_get_mark(0, '"'))
        local buf_line_count = api.nvim_buf_line_count(0)

        if row >= 1 and row <= buf_line_count then -- only within range
            api.nvim_win_set_cursor(0, { row, column })
        end
    end,
})

---------------------------------------------------------------------------
-- :copen will open full width of the screen, by being pushed down to the bottom

-- autocmd filetype qf wincmd J

api.nvim_create_autocmd("FileType", {
    pattern = "qf",
    command = "wincmd J",
})

---------------------------------------------------------------------------
-- when opening a terminal, disable spell checking

api.nvim_create_autocmd("TermOpen", {
    pattern = "*",
    callback = function()
        vim.opt_local.spell = false
    end,
})
