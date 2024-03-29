local choices = {
    -- https://github.com/catppuccin/nvim
    catppuccin = {
        "catppuccin/nvim",
        lazy = false,
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                background = {
                    light = "latte",
                    dark = "mocha",
                },
                show_end_of_buffer = true,
                dim_inactive = {
                    enabled = true,
                    shade = "light",
                    percentage = 0.50,
                },
                integrations = {
                    alpha = true,
                    barbecue = {
                        dim_dirname = true,
                        bold_basename = true,
                        dim_context = true,
                        alt_background = true,
                    },
                    cmp = true,
                    gitsigns = true,
                    neotree = true,
                    treesitter = true,
                    notify = false,
                    markdown = true,
                    mini = {
                        enabled = true,
                        indentscope_color = "lavender",
                    },
                    which_key = false,
                },
            })
            --vim.cmd.colorscheme("catppuccin-latte")
            --vim.cmd.colorscheme("catppuccin-frappe")
            --vim.cmd.colorscheme("catppuccin-macchiato")
            vim.cmd.colorscheme("catppuccin-mocha") -- darkest

            -- make search matches a bit more visible
            vim.cmd([[
            hi CurSearch  guifg=#181825 guibg=#ff9bb8
            hi Search     guifg=#ddddca guibg=#936474

            hi SpellBad   guibg=#500000
            hi SpellCap   guibg=#500070
            hi SpellRare  guibg=#503000
            hi SpellLocal guibg=#700000
            ]])
        end,
    },
    -- https://github.com/folke/tokyonight.nvim
    tokyonight = {
        "folke/tokyonight.nvim",
        lazy = false,
        name = "tokyonight",
        priority = 1000,
        opts = {},
        config = function()
            --vim.cmd.colorscheme("tokyonight-night")
            --vim.cmd.colorscheme("tokyonight-storm")
            vim.cmd.colorscheme("tokyonight-night") -- darkest
            --vim.cmd.colorscheme("tokyonight-day")
            --vim.cmd.colorscheme("tokyonight-moon")
        end,
    },
}
return choices.catppuccin
