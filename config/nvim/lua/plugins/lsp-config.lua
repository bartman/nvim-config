-- https://github.com/williamboman/mason.nvim?tab=readme-ov-file
-- https://github.com/williamboman/mason-lspconfig.nvim
-- https://github.com/neovim/nvim-lspconfig
return {
    {
        "williamboman/mason.nvim", -- installs all the LSPs
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim", -- bridges gap between mason and lspconfig ???
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    -- lsp
                    "lua_ls",
                    "bashls",
                    "clangd",
                    --"cmake",
                    "vimls",
                },
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            local lspconfig = require("lspconfig")

            local border = { ------------- square rounded
                { "╭", "FloatBorder" }, -- 🭽      ╭
                { "─", "FloatBorder" }, -- ▔      ─
                { "╮", "FloatBorder" }, -- 🭾      ╮
                { "│", "FloatBorder" }, -- ▕      │
                { "╯", "FloatBorder" }, -- 🭿      ╯
                { "─", "FloatBorder" }, -- ▁      ─
                { "╰", "FloatBorder" }, -- 🭼      ╰
                { "│", "FloatBorder" }, -- ▏      │
            }
            local handlers = {
                ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
                ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
            }
            vim.diagnostic.config({ border = border })
            require("lspconfig.ui.windows").default_options.border = "single"

            local sopt = { capabilities = capabilities, handlers = handlers }

            lspconfig.lua_ls.setup(sopt)
            lspconfig.bashls.setup(sopt)
            lspconfig.clangd.setup(sopt)
            --lspconfig.cmake.setup(sopt)
            lspconfig.vimls.setup(sopt)

            -- from https://github.com/neovim/nvim-lspconfig?tab=readme-ov-file#suggested-configuration
            -- Global mappings.
            -- See `:help vim.diagnostic.*` for documentation on any of the below functions
            local dopt = {
                source = true,
                border = border,
                severity_sort = true,
            }
            vim.keymap.set("n", "<Leader>lo", function()
                vim.diagnostic.open_float(dopt) -- open a popup at diagnostic location
            end)
            vim.keymap.set("n", "<Leader>ls", function()
                vim.diagnostic.setloclist() -- open quick list with all diagnostics
            end)

            vim.keymap.set("n", "[d", function()
                vim.diagnostic.goto_prev({ float = { border = border } }) -- [d prev diagnostic
            end)
            vim.keymap.set("n", "]d", function()
                vim.diagnostic.goto_next({ float = { border = border } }) -- ]d next diagnostic
            end)

            -- Use LspAttach autocommand to only map the following keys
            -- after the language server attaches to the current buffer
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                callback = function(ev)
                    -- Enable completion triggered by <c-x><c-o>
                    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

                    -- Buffer local mappings.
                    -- See `:help vim.lsp.*` for documentation on any of the below functions

                    local kopt = { buffer = ev.buf }
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, kopt)

                    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, kopt)
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, kopt)
                    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, kopt)
                    vim.keymap.set("n", "<C-k>", function()
                        vim.lsp.buf.signature_help(dopt)
                    end, kopt)
                    vim.keymap.set("n", "<Leader>wa", vim.lsp.buf.add_workspace_folder, kopt)
                    vim.keymap.set("n", "<Leader>wr", vim.lsp.buf.remove_workspace_folder, kopt)
                    vim.keymap.set("n", "<Leader>wl", function()
                        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                    end, kopt)
                    vim.keymap.set("n", "<Leader>D", vim.lsp.buf.type_definition, kopt)
                    vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, kopt)
                    vim.keymap.set({ "n", "v" }, "<Leader>ca", vim.lsp.buf.code_action, kopt)
                    vim.keymap.set("n", "<Leader>cf", vim.lsp.buf.format, kopt)
                    vim.keymap.set("n", "gr", vim.lsp.buf.references, kopt)
                    vim.keymap.set("n", "<Leader>f", function()
                        vim.lsp.buf.format({ async = true })
                    end, kopt)
                end,
            })
        end,
    },
}
