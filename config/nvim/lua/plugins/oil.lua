return {
    "stevearc/oil.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "folke/which-key.nvim",
    },
    config = function()
        local oil = require("oil")
        oil.setup({})

        oil.set_is_hidden_file(function(name, bufnr)
            return vim.startswith(name, ".") or vim.endswith(name, "~")
        end)

        require("which-key").register({
            ["-"] = { "<CMD>Oil<CR>", "oil" },
        })
    end,
}
