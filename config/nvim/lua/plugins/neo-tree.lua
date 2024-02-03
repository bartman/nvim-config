-- https://github.com/nvim-neo-tree/neo-tree.nvim
return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
        "s1n7ax/nvim-window-picker",
        "folke/which-key.nvim",
    },
    config = function()
        require("neo-tree").setup({
            filesystem = {
                filtered_items = {
                    hide_by_pattern = {
                        "*~",
                        ".*~",
                        ".cache/",
                    },
                    always_show = { -- remains visible even if other settings would normally hide it
                        ".gitignore",
                    },
                },
            },
        })
        vim.keymap.set("n", "<C-n>", ":Neotree filesystem toggle left<cr>")
        vim.keymap.set("n", "<Leader>nt", ":Neotree filesystem reveal left<cr>")
        vim.keymap.set("n", "<Leader>ns", ":Neotree git_status reveal left<cr>")

        require("which-key").register({
            n = {
                name = "NeoTree",
                t = "neo tree",
                s = "git status",
            },
        }, { prefix = "<Leader>" })
    end,
}
