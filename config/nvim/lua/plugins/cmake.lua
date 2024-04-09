return {
    {
        -- https://github.com/Civitasv/cmake-tools.nvim
        "Civitasv/cmake-tools.nvim",
        dependencies = {
            "vadimcn/codelldb", -- lldb
        },
        config = function()
            local ct = require'cmake-tools'
            ct.setup({
                cmake_build_directory = 'build',
                cmake_dap_configuration = { -- debug settings for cmake
                    name = "cpp",
                    type = "codelldb",
                    request = "launch",
                    stopOnEntry = false,
                    runInTerminal = true,
                    console = "integratedTerminal",
                },
            })
        end,
    },
    {
        -- https://github.com/hfn92/cmake-gtest.nvim
        "hfn92/cmake-gtest.nvim",
        dependencies = {
            "nvimtools/none-ls.nvim",
        },
        config = function()
            local null_ls = require("null-ls")
            local cmgt = require("cmake-gtest")
            null_ls.register({
                name = 'GTestActions',
                method = {null_ls.methods.CODE_ACTION},
                filetypes = { 'cpp' },
                generator = {
                    fn = function()
                        local actions = cmgt.get_code_actions()
                        if actions == nil then return end
                        local result = {}
                        for idx, v in ipairs(actions.display) do
                            table.insert(result, { title = v, action = actions.fn[idx] })
                        end
                        return result
                    end
                }
            })
        end,
    }
}
