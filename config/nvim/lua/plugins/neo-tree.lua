-- https://github.com/nvim-neo-tree/neo-tree.nvim
return {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = false,
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
                    never_show = {
                        ".cache", -- clangd creates this in the cwd
                    }
                },
            },
        })
        --[[
        vim.keymap.set("n", "<C-n>", ":Neotree filesystem toggle left<cr>")
        vim.keymap.set("n", "<Leader>nt", ":Neotree filesystem reveal left<cr>")
        vim.keymap.set("n", "<Leader>ns", ":Neotree git_status reveal left<cr>")
        --]]

        require("which-key").register({
            ["<C-n>"] = { ":Neotree filesystem toggle left<cr>", "Neotree"},
            ["<Leader>n"] = { name = "neo-tree", },
            ["<Leader>nt"] = { ":Neotree filesystem reveal left<cr>", "neo tree" },
            ["<Leader>ns"] = { ":Neotree git_status reveal left<cr>", "git status" },
            ["<Leader>nb"] = { ":Neotree buffers reveal left<cr>", "buffers" },
        })
    end,
}
