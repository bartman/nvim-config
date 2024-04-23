-- https://github.com/goolord/alpha-nvim
return {
    "goolord/alpha-nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "folke/which-key.nvim",
    },
    config = function()
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.startify")

        dashboard.section.header.val = {
            [[                                                                       ]],
            [[                                                                       ]],
            [[                                                                       ]],
            [[                                                                       ]],
            [[                                                                     ]],
            [[       ████ ██████           █████      ██                     ]],
            [[      ███████████             █████                             ]],
            [[      █████████ ███████████████████ ███   ███████████   ]],
            [[     █████████  ███    █████████████ █████ ██████████████   ]],
            [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
            [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
            [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
            [[                                                                       ]],
            [[                                                                       ]],
            [[                                                                       ]],
        }

        alpha.setup(dashboard.opts)

        require("which-key").register({
            ['<Leader>'] = {
                A = {
                    name = 'alpha',
                    a = { ":Alpha<CR>", "Alpha" },
                    A = { ":Alpha<CR>", "Alpha" },
                }
            },
        })
    end,
}
