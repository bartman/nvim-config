-- https://github.com/mfussenegger/nvim-dap
-- https://github.com/jay-babu/mason-nvim-dap.nvim
return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "vadimcn/codelldb", -- lldb
        "Microsoft/vscode-cpptools", -- gdb
        "rcarriga/nvim-dap-ui",
        "jay-babu/mason-nvim-dap.nvim", -- :DapInstall command, maps mason names to DAP adapter names
        "nvim-lua/plenary.nvim",
        "folke/which-key.nvim",
    },
    config = function()
        local dap, dapui, mnd = require("dap"), require("dapui"), require("mason-nvim-dap")
        local widgets = require("dap.ui.widgets")
        dapui.setup({})
        mnd.setup({
            ensure_installed = { "stylua", "cppdbg", "codelldb", "bash", "python" },
        })

        require("dap.ext.vscode").load_launchjs(nil, { cppdbg = { "c", "cpp" } })

        vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })

        dap.adapters.cppdbg = {
            id = "cppdbg",
            type = "executable",
            command = os.getenv("HOME")
                .. "/.local/share/nvim/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7",
        }

        -- configurations for debugging, see MyDap below
        dap.configurations.cpp = {
            {
                name = "Launch CPP",
                type = "cppdbg",
                request = "launch",
                MIMode = "gdb",
                miDebuggerPath = "/bin/gdb",
                miDebuggerArgs = "--nh",
                cwd = "${workspaceFolder}",
                program = function()
                    error("no executable selected; use ,dd first")
                    --return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                end,
                args = function()
                    error("no arguments provided; use ,dd first")
                    --return vim.fn.input('Arguments for executable: ', vim.fn.getcwd() .. '/', 'file')
                end,
                exception_breakpoints = { "raised" }, -- or raised or uncaught
            },
            {
                name = "Attach to gdbserver :1234",
                type = "cppdbg",
                request = "launch",
                MIMode = "gdb",
                miDebuggerServerAddress = "localhost:1234",
                miDebuggerPath = "/usr/bin/gdb",
                cwd = "${workspaceFolder}",
                program = function()
                    error("no executable selected; use ,dd first")
                    --return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                end,
                args = function()
                    error("no arguments provided; use ,dd first")
                    --return vim.fn.input('Arguments for executable: ', vim.fn.getcwd() .. '/', 'file')
                end,
                exception_breakpoints = { "raised" }, -- or raised or uncaught
            },
        }
        dap.configurations.c = dap.configurations.cpp
        dap.configurations.rust = dap.configurations.cpp

        -- dap.set_log_level("TRACE")

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

        dapui.setup({
            controls = {
                element = "repl",
                enabled = true,
                icons = {
                    disconnect = "",
                    pause = "",
                    play = "",
                    run_last = "",
                    step_back = "",
                    step_into = "",
                    step_out = "",
                    step_over = "",
                    terminate = "❌",
                },
            },
            element_mappings = {},
            expand_lines = true,
            floating = {
                border = "single",
                mappings = {
                    close = { "q", "<Esc>" },
                },
            },
            force_buffers = true,
            icons = {
                collapsed = "",
                current_frame = "",
                expanded = "",
            },
            layouts = {
                {
                    elements = {
                        {
                            id = "scopes",
                            size = 0.25,
                        },
                        {
                            id = "breakpoints",
                            size = 0.25,
                        },
                        {
                            id = "stacks",
                            size = 0.25,
                        },
                        {
                            id = "watches",
                            size = 0.25,
                        },
                    },
                    position = "left",
                    size = 40,
                },
                {
                    elements = {
                        {
                            id = "repl",
                            size = 0.5,
                        },
                        {
                            id = "console",
                            size = 0.5,
                        },
                    },
                    position = "bottom",
                    size = 10,
                },
            },
            mappings = {
                edit = "e",
                expand = { "<CR>", "<2-LeftMouse>" },
                open = "o",
                remove = "d",
                repl = "r",
                toggle = "t",
            },
            render = {
                indent = 1,
                max_value_lines = 100,
            },
        })

        -- MyDap will ask 3 questions:
        --    config type?
        --    executable?
        --    arguments?
        -- then lanuch dap.run() UI

        local MyDap = {}

        MyDap.get_debug_arguments = function(dapcfg) -- ask user for debug arguments
            local choices = {
                "1 2 3",
                "4 5 6",
            }
            vim.ui.select(choices, {
                prompt = "Select arguments for executable",
            }, function(selection)
                --print("argument selection: " .. vim.inspect(selection))

                local words = {}
                if selection then
                    for word in string.gmatch(selection, "%S+") do
                        table.insert(words, word)
                    end
                end

                --print("argument words: " .. vim.inspect(words))
                dapcfg.args = vim.deepcopy(words)

                --print(vim.inspect(dapcfg))

                if not dap.status() == "" then
                    dap.close()
                end

                dap.run(dapcfg, { new = true })
            end)
        end

        MyDap.get_debug_exec = function(dapcfg) -- ask user for executable
            local pjob = require("plenary.job")

            local choices = {}
            pjob
                :new({
                    command = "find",
                    args = { "-type", "f", "!", "-path", "*/.git/*", "!", "-path", "*/CMakeFiles/*", "-executable" },
                    on_stdout = function(_, data)
                        data = string.gsub(data, "^%./", "")
                        table.insert(choices, data)
                    end,
                })
                :sync()

            vim.ui.select(choices, {
                prompt = "Select debug executable",
            }, function(selection)
                --print("exec selection: " .. vim.inspect(selection))
                if not selection or selection == "" then
                    return
                end

                dapcfg.cwd = vim.fn.getcwd()
                dapcfg.program = selection
                MyDap.get_debug_arguments(dapcfg)
            end)
        end

        MyDap.get_debug_type = function(dapcfg) -- ask user for type of config to run
            if dapcfg["name"] and dapcfg["program"] then
                MyDap.get_debug_exec(dapcfg)
                return
            end

            local choices = {}
            for _, cfg in ipairs(dapcfg) do
                table.insert(choices, cfg)
            end

            vim.ui.select(choices, {
                prompt = "Select debug type",
                format_item = function(item)
                    return item.name
                end,
            }, function(selection)
                --print("type selection: " .. vim.inspect(selection))
                if not selection or selection == "" then
                    return
                end
                MyDap.get_debug_exec(selection)
            end)
        end

        MyDap.start = function()
            -- get filetype dapcfg

            local dapcfg = nil
            local bufft = vim.api.nvim_buf_get_option(0, "filetype")
            for _, a in ipairs({ bufft, "fallback" }) do
                local ftcfg = dap.configurations[a]
                if ftcfg then
                    dapcfg = ftcfg
                    break
                end
            end
            if not dapcfg then
                error("no configuration found for filetype=" .. bufft)
            end

            -- start the process

            MyDap.get_debug_type(dapcfg)
        end

        -- keyboard shortcuts for debuggin

        --[[
        vim.keymap.set("n", "<Leader>dd",          MyDap.start)
        vim.keymap.set("n", "<Leader>dc",          function() dap.continue() end)
        vim.keymap.set("n", "<Leader>do",          function() dap.step_over() end)
        vim.keymap.set("n", "<Leader>di",          function() dap.step_into() end)
        vim.keymap.set("n", "<Leader>dr",          function() dap.step_out() end)
        vim.keymap.set("n", "<Leader>dt",          function() dap.toggle_breakpoint() end)
        vim.keymap.set("n", "<Leader>db",          function() dap.set_breakpoint() end)
        vim.keymap.set("n", "<Leader>dl",          function() dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) end)
        vim.keymap.set("n", "<Leader>dO",          function() dap.repl.open() end)
        vim.keymap.set("n", "<Leader>dL",          function() dap.run_last() end)
        vim.keymap.set({ "n", "v" }, "<Leader>dh", function() require("dap.ui.widgets").hover() end)
        vim.keymap.set({ "n", "v" }, "<Leader>dp", function() require("dap.ui.widgets").preview() end)
        vim.keymap.set("n", "<Leader>df", function() widgets.centered_float(widgets.frames) end)
        vim.keymap.set("n", "<Leader>ds", function() widgets.centered_float(widgets.scopes) end)
        --]]

        require("which-key").register({
            d = {
                name = "debugging",
                d = { MyDap.start, "start debugging" },
                c = { dap.continue, "continue", },
                o = { dap.step_over, "step over", },
                i = { dap.step_into, "step into", },
                r = { dap.step_out, "step out", },
                t = { dap.toggle_breakpoint, "toggle BP", },
                b = { dap.set_breakpoint, "set BP", },
                l = { function() dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) end, "log BP", },
                O = { dap.repl.open, "open", },
                L = { dap.run_last, "run last", },
                h = { function() require("dap.ui.widgets").hover() end, "hover", },
                p = { function() require("dap.ui.widgets").preview() end, "preview", },
                f = { function() widgets.centered_float(widgets.frames) end, "curr frame", },
                s = { function() widgets.centered_float(widgets.scopes) end, "curr scope", },
            },
        }, { prefix = "<Leader>" })
    end,
}
