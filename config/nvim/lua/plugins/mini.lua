return {
    "echasnovski/mini.nvim",
    version = "*",
    config = function()
        require("mini.ai").setup()             -- select inside brackets
        require("mini.align").setup()          -- gA to align text
        require("mini.bracketed").setup()      -- [* ]* to move around blocks
        require("mini.comment").setup()        -- gcc comment line, gcip comment paragraph
        require("mini.cursorword").setup()     -- underline word under cursor
        require("mini.jump").setup()           -- f, F, t, T for multiple lines
        require("mini.pairs").setup()          -- bracket and quote pairs
        require("mini.splitjoin").setup()      -- gS to split/join structured text
        require("mini.surround").setup()       -- viwsa) adds () around current word, vipsa} adds {} around paragraph

        local hip = require("mini.hipatterns") -- highlight some words
        hip.setup({
            highlighters = {
                -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
                fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
                hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
                todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
                note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

                -- Highlight hex color strings (`#rrggbb`) using that color
                hex_color = hip.gen_highlighter.hex_color(),
            },
        })

        local ids = require("mini.indentscope") -- animated vertical line
        ids.setup({
            --symbol = '╎',
            symbol = "⁞",
        })

        local mm = require("mini.map") -- minimap
        mm.setup()
        vim.keymap.set("n", "<Leader>mm", mm.toggle)

        local op = require("mini.operators") -- execute code
        op.setup({
            evaluate = { prefix = "g=" },    -- g== eval line,
            replace = { prefix = "gr" },     -- gr replace with a register
            sort = { prefix = "gs" },        -- gs sort selection
        })

        local br = require("mini.bracketed")
        br.setup({
            buffer     = { suffix = 'b', options = {} },
            comment    = { suffix = 'c', options = {} },
            conflict   = { suffix = 'x', options = {} },
            diagnostic = { suffix = '', options = {} }, -- DISABLED: prefer the one from lsp-config.lua
            file       = { suffix = 'f', options = {} },
            indent     = { suffix = 'i', options = {} },
            jump       = { suffix = 'j', options = {} },
            location   = { suffix = 'l', options = {} },
            oldfile    = { suffix = 'o', options = {} },
            quickfix   = { suffix = 'q', options = {} },
            treesitter = { suffix = 't', options = {} },
            undo       = { suffix = 'u', options = {} },
            window     = { suffix = 'w', options = {} },
            yank       = { suffix = 'y', options = {} },

        })
    end,
}
