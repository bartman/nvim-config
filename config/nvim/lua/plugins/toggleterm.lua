-- https://github.com/akinsho/toggleterm.nvim
return {
    "akinsho/toggleterm.nvim",
    config = function()
        local tt = require("toggleterm")
        tt.setup({
            insert_mappings = false,
            open_mapping = [[<c-\>]],
        })
    end,
}
