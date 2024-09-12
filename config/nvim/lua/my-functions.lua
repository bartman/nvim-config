local vim = vim
---------------------------------------------------------------------------
-- :A - switches between .h and .c files
-- this is a lua port of :A from https://www.vim.org/scripts/script.php?script_id=31
-- (at least a part of the plugin that I used)

local function switch_to_alternate_file()
    local current_path = vim.api.nvim_buf_get_name(0)
    local alternate_path

    if string.match(current_path, "%.cpp$") then
        alternate_path = string.gsub(current_path, "%.cpp$", ".hpp")
    elseif string.match(current_path, "%.hpp$") then
        alternate_path = string.gsub(current_path, "%.hpp$", ".cpp")
    elseif string.match(current_path, "%.c$") then
        alternate_path = string.gsub(current_path, "%.c$", ".h")
    elseif string.match(current_path, "%.h$") then
        alternate_path = string.gsub(current_path, "%.h$", ".c")
    else
        print("Not a C/C++ source or header file")
        return
    end

    -- Check if the alternate file exists
    local f = io.open(alternate_path, "r")
    if f then
        io.close(f)
        vim.api.nvim_command('edit ' .. alternate_path)
        return
    end

    -- this is the file name without leading directory
    local alternate_file = vim.fn.fnamemodify(alternate_path, ":t")

    -- iterate over all open buffers
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        -- Check if buffer is valid and has a name
        local buffer_path = vim.api.nvim_buf_get_name(buf)
        if vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_buf_get_name(buf) ~= "" then
            -- Extract buffer name (file) and compare with the target filename
            local buffer_name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ":t")
            if buffer_name == alternate_file then
                -- Switch to the buffer
                vim.api.nvim_set_current_buf(buf)
                return
            end
        end
    end

    -- iterate over recent buffers
    for _, buf in ipairs(vim.fn.getbufinfo({ buflisted = 1 })) do
        -- Check if the buffer has a name (file path)
        if buf.name ~= "" then
            -- Extract buffer name (file) and compare with the target filename
            local buffer_name = vim.fn.fnamemodify(buf.name, ":t")
            if buffer_name == alternate_file then
                -- Switch to the buffer
                vim.api.nvim_set_current_buf(buf.bufnr)
                return
            end
        end
    end

    print("Alternate file does not exist: " .. alternate_file)
end
vim.api.nvim_create_user_command('A', switch_to_alternate_file, {})

