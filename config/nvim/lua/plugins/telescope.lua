-- https://github.com/nvim-telescope/telescope.nvim
-- https://github.com/nvim-telescope/telescope-ui-select.nvim
return {
    {
        "nvim-telescope/telescope.nvim",
        --tag = "0.1.5",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "folke/which-key.nvim",
        },
        config = function()
            local ts = require("telescope.builtin")
            --[[
            vim.keymap.set("n", "<C-p>", ts.find_files, {})
            vim.keymap.set("n", "<Leader>ff", ts.find_files, {})
            vim.keymap.set("n", "<Leader>fg", ts.live_grep, {})
            vim.keymap.set("n", "<Leader>tt", "<Esc>:Telescope<CR>", {})
            --]]

            require("which-key").register({
                ["<C-p>"] = { ts.find_files, "find files" },
                ["<Leader>"] = {
                    f = {
                        name = "telescope",
                        a = { "<cmd>Telescope<cr>", "Telescope" },
                        f ={ ts.find_files,"files",     },
                        g ={ ts.live_grep,"live grep",      },
                        b ={ ts.buffers,"buffers",   },
                        h ={ ts.help_tags,"help", },
                        m ={ ts.man_pages,"man pages", },
                        v ={ ts.vim_options,"vim options", },
                        r ={ ts.registers,"registers", },
                        k ={ ts.keymaps,"keymaps", },
                    },
                }
            })
        end,
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
        config = function()
            require("telescope").setup({
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({}),
                    },
                },
            })
            -- To get ui-select loaded and working with telescope, you need to call
            -- load_extension, somewhere after setup function:
            require("telescope").load_extension("ui-select")
        end,
    },
}
