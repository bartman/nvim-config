return {
    'bartman/history-select.nvim',
    enabled = false,
    dependencies = {
        "folke/which-key.nvim",
    },
    config = function()
        Q1 = { ask = nil }
        Q2 = { ask = nil }

        require("which-key").register({
            x = {
                name = "testing",
                ['1'] = {
                    function()
                        Q1:ask()
                    end, "Q1" },
                ['2'] = {
                    function()
                        Q2:ask()
                    end, "Q2" },
                r = {
                    function()
                        package.loaded['history-select'] = nil
                        vim.api.nvim_command('messages clear')
                        local hs = require('history-select')
                        Q1 = hs.new( { title = 'Question 1...', history_file = 'Q1' })
                        Q2 = hs.new( { title = 'Question 2...', history_file = 'Q2' })
                    end, "reset" },
            },
        }, { prefix = "<Leader>" })
    end
}
