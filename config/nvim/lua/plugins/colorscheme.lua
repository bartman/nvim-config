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
                    shade = "dark",
                    percentage = 0.15,
                },
                integrations = {
                    alpha = true,
                    barbecue = {
                        dim_dirname = true, -- directory name is dimmed by default
                        bold_basename = true,
                        dim_context = false,
                        alt_background = false,
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
