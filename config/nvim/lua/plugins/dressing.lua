return {
    "stevearc/dressing.nvim",
    dependencies = {
        "nvim-telescope/telescope.nvim",
    },
    config = function()
        require("dressing").setup({
            input = {
                enabled = true,
            },
            select = {
                enabled = true,
                backend = { "telescope", "builtin" },
                builtin = {
                    border = "rounded",
                },
            },
        })
    end,
}
