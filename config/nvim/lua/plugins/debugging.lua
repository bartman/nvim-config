-- https://github.com/mfussenegger/nvim-dap
-- https://github.com/jay-babu/mason-nvim-dap.nvim
return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "vadimcn/codelldb",          -- lldb
        "Microsoft/vscode-cpptools", -- gdb
        "rcarriga/nvim-dap-ui",
        "jay-babu/mason-nvim-dap.nvim",
        "tpope/vim-fugitive",
    },
    config = function()
        local dap, dapui, mnd = require("dap"), require("dapui"), require("mason-nvim-dap")
        dapui.setup({})
        mnd.setup({
            ensure_installed = { "cppdbg", "codelldb", "bash", "python" },
        })

        require("dap.ext.vscode").load_launchjs(nil, { cppdbg = { "c", "cpp" } })

        vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })

        dap.adapters.cppdbg = {
            id = "cppdbg",
            type = "executable",
            command = os.getenv("HOME")
                .. "/.local/share/nvim/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7",
        }

        dap.configurations.cpp = {
            {
                type = "cppdbg",
                request = "launch",
                name = "Launch CPP",
                MIMode = "gdb",
                miDebuggerPath = "/bin/gdb",
                miDebuggerArgs = "--nh",
                --MIMode= "lldb",
                --miDebuggerPath= "/bin/lldb",
                program = "build/cppmain",
                cwd = os.getenv("PWD"),
                args = { "1", "2", "3", "4" },
            },
        }

        dap.set_log_level("TRACE")

        --require("cpptools") -- use gdb
        --require("codelldb") -- use lldb

        dap.listeners.before.attach.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
        end

        --[[
        vim.keymap.set("n", "<Leader>dt", ":DapToggleBreakpoint<CR>")
		vim.keymap.set("n", "<Leader>dc", ":DapContinue<CR>")
		vim.keymap.set("n", "<Leader>dx", ":DapTerminate<CR>")
		vim.keymap.set("n", "<Leader>do", ":DapStepOver<CR>")
        --]]

        vim.keymap.set("n", "<Leader>dc", function()
            dap.continue()
        end)
        vim.keymap.set("n", "<Leader>do", function()
            dap.step_over()
        end)
        vim.keymap.set("n", "<Leader>di", function()
            dap.step_into()
        end)
        vim.keymap.set("n", "<Leader>dr", function()
            dap.step_out()
        end)
        vim.keymap.set("n", "<Leader>dt", function()
            dap.toggle_breakpoint()
        end)
        vim.keymap.set("n", "<Leader>db", function()
            dap.set_breakpoint()
        end)
        vim.keymap.set("n", "<Leader>dl", function()
            dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
        end)
        vim.keymap.set("n", "<Leader>dO", function()
            dap.repl.open()
        end)
        vim.keymap.set("n", "<Leader>dl", function()
            dap.run_last()
        end)
        vim.keymap.set({ "n", "v" }, "<Leader>dh", function()
            require("dap.ui.widgets").hover()
        end)
        vim.keymap.set({ "n", "v" }, "<Leader>dp", function()
            require("dap.ui.widgets").preview()
        end)
        vim.keymap.set("n", "<Leader>df", function()
            local widgets = require("dap.ui.widgets")
            widgets.centered_float(widgets.frames)
        end)
        vim.keymap.set("n", "<Leader>ds", function()
            local widgets = require("dap.ui.widgets")
            widgets.centered_float(widgets.scopes)
        end)
    end,
}
