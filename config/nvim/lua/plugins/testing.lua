return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "alfaix/neotest-gtest",
        "folke/which-key.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        local nt = require("neotest")
        local lib = require("neotest.lib")

        nt.setup({
            adapters = {
                require("neotest-gtest").setup({
                    root = lib.files.match_root_pattern(".git", "build"),
                    debug_adapter = 'cppdbg',
                })
            }
        })

        require("which-key").register({
            ["<Leader>"] = {
                t = {
                    name = "testing",
                    o ={ function() require("neotest").summary.open() end,                 "open",           },
                    n ={ function() require("neotest").run.run() end,                      "nearest",        },
                    c ={ function() require("neotest").run.run(vim.fn.expand("%")) end,    "current",        },
                    d ={ function() require("neotest").run.run({strategy = "dap"}) end,    "debug nearest",  },
                },
            }
        })
    end
}
