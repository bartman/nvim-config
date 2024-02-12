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

            local opts = {
                prompt_prefix = '🔭', -- 🔭 🔍
                selection_caret = '▶', -- ⭐🪐 ➡️ ▶
            }

            require("which-key").register({
                ["<C-p>"] = { ts.find_files, "find files" },
                ["<Leader>"] = {
                    f = {
                        name = "telescope",
                        a = { function() ts.builtin(opts) end, "all builtins"},
                        b = { function() ts.buffers(opts) end, "buffers"},
                        c = { function() ts.commands(opts) end, "commands"},
                        f = { function() ts.find_files(opts) end, "files"},
                        g = { function() ts.live_grep(opts) end, "live grep"},
                        h = { function() ts.help_tags(opts) end, "help"},
                        k = { function() ts.keymaps(opts) end, "keymaps"},
                        m = { function() ts.man_pages(opts) end, "man pages"},
                        r = { function() ts.registers(opts) end, "registers"},
                        t = { function() ts.tags(opts) end, "tags"},
                        v = { function() ts.vim_options(opts) end, "vim options"},
                    },
                },
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
