-- https://github.com/akinsho/toggleterm.nvim
return {
    "akinsho/toggleterm.nvim",
    config = function()
        require("toggleterm").setup({
            insert_mappings = false,
            open_mapping = [[<c-\>]],
        })
        require("which-key").register({
            ["<C-\\>"] = "Toggleterm",
        })
    end,
}
