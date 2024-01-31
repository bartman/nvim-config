-- https://github.com/nvim-treesitter/nvim-treesitter/wiki/Installation
return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        local configs = require("nvim-treesitter.configs")
        configs.setup({
            ensure_installed = { "c", "cpp", "lua", "vim", "vimdoc", "cmake" },
            auto_install = true,
            sync_install = true,
            highlight = { enable = true },
            indent = { enable = true },
        })
    end,
}
