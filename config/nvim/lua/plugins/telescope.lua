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
            vim.keymap.set("n", "<C-p>", ts.find_files, {})
            vim.keymap.set("n", "<Leader>ff", ts.find_files, {})
            vim.keymap.set("n", "<Leader>fg", ts.live_grep, {})
            vim.keymap.set("n", "<Leader>tt", "<Esc>:Telescope<CR>", {})

            require("which-key").register({
                t = {
                    t = "telescope",
                },
                f = {
                    name = "find",
                    f = "find files",
                    g = "live grep",
                    b = "find buffers",
                    h = "find help tags",
                },
            }, { prefix = "<Leader>" })
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
