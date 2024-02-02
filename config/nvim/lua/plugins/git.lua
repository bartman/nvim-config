-- https://github.com/aspeddro/gitui.nvim
-- https://github.com/lewis6991/gitsigns.nvim
return {
    {
        "aspeddro/gitui.nvim",
        config = function()
            local gitui = require("gitui")
            gitui.setup({})

            vim.keymap.set("n", "<Leader>gu", function()
                gitui.open()
            end)
        end,
    },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            local gitsigns = require("gitsigns")

            gitsigns.setup({
                auto_attach = true,
                current_line_blame = true,
                current_line_blame_formatter = " 👤 <author>, <author_time:%Y-%m-%d> - <summary>",
                current_line_blame_formatter_nc = "", -- not committed
                current_line_blame_opts = {
                    virt_text = true,
                    virt_text_pos = "right_align", -- 'eol' | 'overlay' | 'right_align'
                    delay = 1000,
                    ignore_whitespace = true,
                    virt_text_priority = 1,
                    relative_time = false,
                },
                signs = {
                    add = { text = "➕" },
                    change = { text = "‼️" },
                    delete = { text = "_" },
                    topdelete = { text = "‾" },
                    changedelete = { text = "~" },
                    untracked = { text = "┆" },
                },
            })

            vim.api.nvim_set_hl(0, "GitSignsCurrentLineBlame", { fg = "#85878a" })
        end,
    },
    {
        "tpope/vim-fugitive",
        config = function()
            --vim.keymap.set("n", "<Leader>gs", ":Git<cr>")
            vim.keymap.set("n", "<Leader>gd", ":Gdiffsplit<cr>")
            vim.keymap.set("n", "<Leader>gc", ":Git commit<cr>")
            vim.keymap.set("n", "<Leader>gb", ":Git blame<cr>")
            vim.keymap.set("n", "<Leader>gl", ":Gclog<cr>")
            vim.keymap.set("n", "<Leader>gg", ":copen<CR>:Ggrep -q -e '<C-R>=getreg('/')<Enter>'<CR>")

            --[[
            map <LocalLeader>gs :Git<cr>
            map <LocalLeader>gd :Gdiffsplit<cr>
            map <LocalLeader>gc :Gcommit<cr>
            map <LocalLeader>gb :Git blame<cr>
            map <LocalLeader>gl :Gclog<cr>
            map <LocalLeader>gg :copen<CR>:Ggrep -e '<C-R>=getreg('/')<Enter>'<CR>
            --]]
        end
    },
}
