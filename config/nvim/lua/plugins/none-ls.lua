-- https://github.com/nvimtools/none-ls.nvim
return {
    "nvimtools/none-ls.nvim",
    config = function()
        local null_ls = require("null-ls")

        null_ls.setup({
            on_init = function(client, _)
                client.offset_encoding = 'utf-16' -- this needs to match lsp-config
            end,
            sources = {
                -- lua
                null_ls.builtins.formatting.stylua.with({
                    extra_args = {
                        "--indent-type",
                        "spaces",
                        "--indent-width",
                        "4",
                    },
                }),

                -- git
                null_ls.builtins.code_actions.gitsigns,

                -- C/C++
                --null_ls.builtins.diagnostics.clang_check.with({}),
                null_ls.builtins.diagnostics.cppcheck.with({}),
                --null_ls.builtins.diagnostics.cpplint.with({ extra_args = { '—-filter=-legal/copyright' } }), -- doesn't know C++20
                null_ls.builtins.formatting.clang_format.with({}),

                -- spelling
                --null_ls.builtins.completion.spell.with({}),
                --null_ls.builtins.diagnostics.codespell.with({}), -- yellow warning
                --null_ls.builtins.diagnostics.misspell.with({}), -- blue info

                -- python
                null_ls.builtins.diagnostics.pylint.with({}),
                null_ls.builtins.formatting.isort.with({}),
                null_ls.builtins.formatting.black.with({}),

                -- cmake
                null_ls.builtins.diagnostics.cmake_lint.with({}),
                null_ls.builtins.formatting.cmake_format.with({}),

                -- shell
                --null_ls.builtins.diagnostics.dotenv_linter.with({}),
                --null_ls.builtins.diagnostics.shellcheck.with({}),
                --null_ls.builtins.formatting.beautysh.with({}),
            },
        })
    end,
}
