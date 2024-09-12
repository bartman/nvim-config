-- https://www.reddit.com/r/neovim/comments/1ekl7rn/markviewnvim_just_had_its_first_proper_release/
-- https://github.com/OXY2DEV/markview.nvim
return {
    {
        "OXY2DEV/markview.nvim",
        lazy = false,
        -- enabled = false,
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons"
        }
    }
}
