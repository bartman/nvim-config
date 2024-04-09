-- https://github.com/nvim-lualine/lualine.nvim
-- https://github.com/meuter/lualine-so-fancy.nvim
return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "meuter/lualine-so-fancy.nvim",
        "nomnivore/ollama.nvim",
    },
    config = function()

        local function get_ollama_status()
            local status = require("ollama").status()
            if status == "IDLE" then
                return "󱙺"
            elseif status == "WORKING" then
                return "󰚩"
            end
        end

        require("lualine").setup({
            options = {
                icons_enabled = true,
                theme = "catppuccin",
                --theme = 'tokyonight',
                component_separators = { left = "", right = "" },
                section_separators = { left = "", right = "" },
                disabled_filetypes = {
                    statusline = {},
                    winbar = {},
                },
                ignore_focus = {},
                always_divide_middle = true,
                globalstatus = false,
                refresh = {
                    statusline = 1000,
                    tabline = 1000,
                    winbar = 1000,
                },
            },
            sections = {
                lualine_a = {
                    { "fancy_mode", width = 6 },
                },
                lualine_b = {
                    { "fancy_branch" },
                    { "fancy_diff" },
                    { "fancy_diagnostics" },
                    { "fancy_macro" },
                    get_ollama_status,
                },
                lualine_c = {
                    {
                        "filename",
                        substitute_home = true,
                        colored = true,
                        file_status = true, -- Displays file status (readonly status, modified status)
                        newfile_status = true, -- Display new file status (new file means no write after created)
                        path = 1, -- 0: Just the filename
                        -- 1: Relative path
                        -- 2: Absolute path
                        -- 3: Absolute path, with tilde as the home directory
                        -- 4: Filename and parent dir, with tilde as the home directory

                        shorting_target = 40, -- Shortens path to leave 40 spaces in the window
                        -- for other components. (terrible name, any suggestions?)
                        symbols = {
                            modified = "🖋️", -- [+] Text to show when the file is modified.
                            readonly = "🔍", -- [-] Text to show when the file is non-modifiable or readonly.
                            unnamed = "⁉️", -- Text to show for unnamed buffers.
                            newfile = "🌟", -- Text to show for newly created file before first write
                        },
                    },
                },
                lualine_x = {
                    { "fancy_searchcount" },
                    --{ "fancy_lsp_servers" },
                },
                lualine_y = {
                    { "encoding" },
                    { "fileformat" },
                    { "fancy_filetype", ts_icon = "" },
                },
                lualine_z = {
                    { "progress" },
                    { "fancy_location" },
                },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { { "filename", path = 1 } },
                lualine_x = { "location" },
                lualine_y = {},
                lualine_z = {},
            },
            tabline = {},
            winbar = {},
            inactive_winbar = {},
            extensions = { "quickfix", "neo-tree", "fugitive", "man", "toggleterm" },
        })
    end,
}
