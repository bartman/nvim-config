-- https://github.com/folke/which-key.nvim
return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
    end,
    opts = {},
    config = function()
        require("which-key").register({
            ["<Leader>so"] = { "<cmd>:source $MYVIMRC<CR>", "reload vimrc" },
            ["<Leader>ss"] = { "<cmd>:set spell!<CR>", "toggle spelling" },
        })

        -- find merge conflict markers
        vim.cmd([[
        map <Leader>ss /\v^[<\|=>]{7}( .*\|$)<CR>
        ]])

    end
}
