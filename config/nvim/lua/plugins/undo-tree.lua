-- https://github.com/jiaoshijie/undotree
return {
    "jiaoshijie/undotree",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "folke/which-key.nvim",
    },
    config = true,
    keys = { -- load the plugin only when using it's keybinding:
        { "<Leader>ut", "<cmd>lua require('undotree').toggle()<cr>" },
    },
    require("which-key").register({
        u = {
            t = "undo tree",
        },
    }, { prefix = "<Leader>" }),
}
