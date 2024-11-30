return {
    {
        "stevearc/oil.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "folke/which-key.nvim",
        },
        config = function()
            local oil = require("oil")
            oil.setup({
                default_file_explorer = true,
                delete_to_trash = true,
                skip_confirm_for_simple_edits = true,
                view_options = {
                    show_hidden = true,
                    natural_order = true,
                    is_always_hidden = function(name, _)
                        return name == '..'
                            or name == '.git'
                            or vim.startswith(name, '.')
                            or vim.endswith(name, '~')
                    end,
                },
                win_options = {
                    wrap = true,
                },
                keymaps = {
                }
            })

            require("which-key").register({
                ["-"] = { "<CMD>Oil<CR>", "oil" },
            })
        end,
    },
    {
        -- replaces 'gx' command for use with oil, not NetRW
        "chrishrb/gx.nvim",
        enabled = false,
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
        cmd = { "Browse" },
        init = function()
            vim.g.netrw_nogx = 1 -- disable netrw gx command
        end,
        submodules = false, -- not needed, submodules are required only for testing
        config = function()

            require("which-key").register({
                ["gx"] = { "<CMD>Browse<CR>", "gx" },
            })
        end,
    }
}
