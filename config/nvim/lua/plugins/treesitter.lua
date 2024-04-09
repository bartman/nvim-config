-- https://github.com/nvim-treesitter/nvim-treesitter/wiki/Installation
return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {},
    config = function()
        local configs = require("nvim-treesitter.configs")
        configs.setup({
            ensure_installed = { "c", "cpp", "lua", "vim", "vimdoc", "cmake", "markdown" },
            auto_install = true,
            sync_install = true,
            highlight = { enable = true },
            indent = { enable = true },
        })

        local vim = vim
        vim.opt.foldmethod = "expr"
        vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
        vim.opt.foldlevel = 99 -- keep folds open by default (for the first 99 levels)
    end,
}
