-- https://github.com/aspeddro/gitui.nvim
-- https://github.com/kdheepak/lazygit.nvim
-- https://github.com/lewis6991/gitsigns.nvim
return {
    {
        "kdheepak/lazygit.nvim",
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "nvim-lua/plenary.nvim",
            "folke/which-key.nvim",
        },
        config = function()
            require("telescope").load_extension("lazygit")
            require("which-key").register({
                g = {
                    name = "git",
                    z = { "<cmd>LazyGit<cr>", "lazy git ui" },
                },
            }, { prefix = "<Leader>" })
        end,
    },
    --[[
    {
        "aspeddro/gitui.nvim",
        dependencies = {
            "folke/which-key.nvim",
        },
        config = function()
            local gitui = require("gitui")
            gitui.setup({})

            vim.keymap.set("n", "<Leader>gu", function()
                gitui.open()
            end)

            require("which-key").register({
                g = {
                    name = "git",
                    u = "gitui",
                },
            }, { prefix = "<Leader>" })
        end,
    },
    --]]
    {
        "lewis6991/gitsigns.nvim",
        dependencies = {
            "folke/which-key.nvim",
        },
        config = function()
            local gitsigns = require("gitsigns")

            gitsigns.setup({
                auto_attach = true,
                signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
                numhl      = true,  -- Toggle with `:Gitsigns toggle_numhl`
                linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
                word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
                watch_gitdir = {
                    follow_files = true
                },
                current_line_blame = false,
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
                    add          = { text = '┃' }, -- ┃ │ ║
                    change       = { text = '║' }, -- 
                    delete       = { text = '▂' }, -- ▁ ▂ ▃ ▄ 
                    topdelete    = { text = '▔' }, -- ‾ ▔ ▔ ▀ 
                    changedelete = { text = '~' }, -- ~ ⫔ 
                    untracked    = { text = '⦚' }, -- ┆ ⋮ ⦚
                },
                -- on_attach = function(bufnr)
                --     local function map(mode, l, r, opts)
                --         opts = opts or {}
                --         opts.buffer = bufnr
                --         vim.keymap.set(mode, l, r, opts)
                --     end
                --
                --     -- Navigation
                --     map("n", "]g", function()
                --         --if vim.wo.diff then return ']c' end
                --         vim.schedule(function()
                --             gitsigns.next_hunk()
                --         end)
                --         return "<Ignore>"
                --     end, { expr = true })
                --     
                --     map("n", "[g", function()
                --         --if vim.wo.diff then return '[c' end
                --         vim.schedule(function()
                --             gitsigns.prev_hunk()
                --         end)
                --         return "<Ignore>"
                --     end, { expr = true })
                --
                --     -- Actions
                --     map("n", "<Leader>ga", gitsigns.stage_hunk)
                --     map("n", "<Leader>gr", gitsigns.reset_hunk)
                --     map("n", "<Leader>gA", gitsigns.stage_buffer)
                --     map("n", "<Leader>gR", gitsigns.reset_buffer)
                --     map("n", "<Leader>gp", gitsigns.preview_hunk)
                --
                --     --map('v', '<Leader>hs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
                --     --map('v', '<Leader>hr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
                --     --map('n', '<Leader>hu', gs.undo_stage_hunk)
                --     --map('n', '<Leader>hb', function() gs.blame_line{full=true} end)
                --     --map('n', '<Leader>tb', gs.toggle_current_line_blame)
                --     --map('n', '<Leader>hd', gs.diffthis)
                --     --map('n', '<Leader>hD', function() gs.diffthis('~') end)
                --     --map('n', '<Leader>td', gs.toggle_deleted)
                --
                --     -- Text object
                --     --map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
                -- end,
            })

            vim.api.nvim_set_hl(0, "GitSignsCurrentLineBlame", { fg = "#85878a" })

            require("which-key").register({
                ["<Leader>"] = {
                    g = {
                        name = "git",
                        a = { gitsigns.stage_hunk, "stage hunk" },
                        r = { gitsigns.reset_hunk, "reset hunk" },
                        A = { gitsigns.stage_buffer, "stage buffer" },
                        R = { gitsigns.reset_buffer, "reset buffer" },
                        p = { gitsigns.preview_hunk, "preview hunk" },
                        t = { gitsigns.toggle_current_line_blame, "toggle blame" },
                    },
                },
                ["[g"] = { gitsigns.prev_hunk, "Previous git hunk" },
                ["]g"] = { gitsigns.next_hunk, "Next git hunk" },
            })
        end,
    },
    {
        "tpope/vim-fugitive",
        config = function()
            --[[
            vim.keymap.set("n", "<Leader>gd", ":Gdiffsplit<cr>")
            vim.keymap.set("n", "<Leader>gc", ":Git commit<cr>")
            vim.keymap.set("n", "<Leader>gb", ":Git blame<cr>")
            vim.keymap.set("n", "<Leader>gl", ":Gclog<cr>")
            vim.keymap.set("n", "<Leader>gg", ":copen<CR>:Ggrep -q -e '<C-R>=getreg('/')<Enter>'<CR>")
            --]]

            require("which-key").register({
                g = {
                    name = "git",
                    d = { ":Gdiffsplit<cr>", "diff split" },
                    c = { ":Git commit<cr>", "commit" },
                    b = { ":Git blame<cr>", "blame" },
                    l = { ":Gclog<cr>", "log" },
                    g = { ":copen<CR>:Ggrep -q -e '<C-R>=getreg('/')<Enter>'<CR>", "grep" },
                },
            }, { prefix = "<Leader>" })
        end,
    },
}
