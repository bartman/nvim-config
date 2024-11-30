-- this plugin uses ollama server to run an open source LLM
-- locally and get results from it.  to use it you will have
-- to have ollama installed, so do that first
-- https://github.com/ollama/ollama
return {
    {
        "nomnivore/ollama.nvim",
        enabled = true,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "folke/which-key.nvim",
        },
        -- All the user commands added by the plugin
        cmd = { "Ollama", "OllamaModel", "OllamaServe", "OllamaServeStop" },

        keys = {
            -- Sample keybind for prompt menu. Note that the <c-u> is important for selections to work properly.
            {
                "<leader>oo",
                ":<c-u>lua require('ollama').prompt()<cr>",
                desc = "ollama prompt",
                mode = { "n", "v" },
            },

            -- Sample keybind for direct prompting. Note that the <c-u> is important for selections to work properly.
            {
                "<leader>oG",
                ":<c-u>lua require('ollama').prompt('Generate_Code')<cr>",
                desc = "ollama Generate Code",
                mode = { "n", "v" },
            },
        },

        config = function()
            require("which-key").register({
                mode = { 'v', 'n' },
                ["<Leader>o"] = { name = "ollama" }
            })
        end,

        ---@type Ollama.Config
        opts = {
            -- model = "llama2:13b",
            model = "llama3:instruct",
        }
    },
    {
        -- https://github.com/jpmcb/nvim-llama
        -- uses docker, for some reason, it's also very slow, but it does work, and is local
        'jpmcb/nvim-llama',
        enabled = false,
        dependencies = {
            "folke/which-key.nvim",
        },
        config = function()
            require'nvim-llama'.setup({
                debug = false,
                model = 'llama2:13b',
            })

            require("which-key").register({
                mode = { 'v', 'n' },
                ["<Leader>a"] = {
                    name = "AI",
                    l = { "<cmd>Llama<CR>", "Llama" },
                },
            })
        end,
    },
    {
        "olimorris/codecompanion.nvim",
        enabled = true,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            -- The following are optional:
            { "MeanderingProgrammer/render-markdown.nvim", ft = { "markdown", "codecompanion" } },
            "folke/which-key.nvim",
        },
        config = function()
            require('codecompanion').setup({
                strategies = {
                    chat = { adapter = "openai" },
                    inline = { adapter = "openai" },
                },
                adapters = {
                    openai = function()
                        return require("codecompanion.adapters").extend("openai", {
                            schema = {
                                model = {
                                    default = "gpt-4o"
                                }
                            }
                        })
                    end,
                    xai = function()
                        return require("codecompanion.adapters").extend("xai", {
                            schema = {
                                model = {
                                    default = "grok-beta"
                                }
                            }
                        })
                    end,
                    ollama = function()
                        return require("codecompanion.adapters").extend("ollama", {
                            schema = {
                                model = {
                                    default = "llama3:latest"
                                }
                            }
                        })
                    end,
                }
            })
            require("which-key").register({
                mode = { 'v', 'n' },
                ["<Leader>C"] = {
                    name = "CodeCompanion",
                    a = { "<cmd>CodeCompanionActions<CR>", "Actions" },
                    A = { "<cmd>CodeCompanionActions<CR>", hidden = true },
                    c = { "<cmd>CodeCompanionChat Toggle<CR>", "Chat toggle" },
                    C = { "<cmd>CodeCompanionChat Toggle<CR>", hidden = true },
                    ["+"] = { "<cmd>CodeCompanionChat Add<CR>", "Chat add" },
                },
            })
        end,
    },
    {
        -- https://github.com/David-Kunz/gen.nvim
        -- nicer plugin, no docker

        "David-Kunz/gen.nvim",
        enabled = false,
        --"bartman/gen.nvim",
        --branch = 'allow-prompt-function-to-cancel-generate',

        dependencies = {
            "folke/which-key.nvim",
        },
        config = function()
            local gen = require'gen'
            gen.setup({
                --model = "mistral",
                --model = 'llama2:13b',
                model = 'llama3:instruct',

                -- https://ollama.com/library/stable-code
                --model = 'stable-code',

                -- https://ollama.com/library/codellama
                --model = 'codellama:13b-code',
                --model = 'codellama:13b-instruct',

                -- 💫 https://ollama.com/library/starcoder2
                --model = "starcoder2:15b", -- 600+ languages
                --model = "starcoder2:7b", -- 17 languages

                --
                host = "localhost", -- The host running the Ollama service.
                port = "11434", -- The port on which the Ollama service is listening.
                display_mode = "split", -- The display mode. Can be "float" or "split".
                show_prompt = false, -- Shows the Prompt submitted to Ollama.
                show_model = true, -- Displays which model you are using at the beginning of your chat session.
                no_auto_close = false, -- Never closes the window automatically.
                init = function(options)
                    pcall(io.popen, "ollama serve > /dev/null 2>&1 &")
                end,
                -- Function to initialize Ollama
                command = function(options)
                    return "curl --silent --no-buffer -X POST http://" .. options.host .. ":" .. options.port .. "/api/generate -d $body"
                end,
                -- The command for the Ollama service. You can use placeholders $prompt, $model and $body (shellescaped).
                -- This can also be a command string.
                -- The executed command must return a JSON object with { response, context }
                -- (context property is optional).
                -- list_models = '<omitted lua function>', -- Retrieves a list of model names
                debug = false -- Prints errors and the command which is run.
            })

            gen.prompts['Comment_to_code'] = {
                prompt = "Using $filetype generate code for the following comment block:"
                    .. "$text\n"
                ,
            }
            gen.prompts['Comment_replace_with_code'] = {
                prompt = "Using $filetype generate code for the following comment block.  Support latest features of the language.  "
                    .. "Add good comments to the code.  Only output the result in format ```$filetype\n...\n```:\n"
                    .. "```$filetype\n$text\n```\n"
                ,
                replace = true,
                extract = "```$filetype\n(.-)```"
            }
            gen.prompts['Testcases_for_code'] = {
                prompt = function(opt)
                    if opt.content == "" then
                        print("content is empty!")
                        return nil
                    end
                    if opt.filetype == 'cpp' or opt.filetype == 'c' then
                        return "Using C++20 and googletest generate testcases for the following code:"
                            .. opt.content .. "\n"
                    else
                        return "Using $filetype generate testcases for the following code:"
                            .. opt.content .. "\n"
                    end
                end
            }

            -- require("which-key").register({
            --     mode = { 'v', 'n' },
            --     ["<Leader>cg"] = { ":Gen<CR>", "Gen", },
            -- })

        end,
    },
    {
        "jackMort/ChatGPT.nvim",
        enabled = true,
        dependencies = {
            "MunifTanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
            "folke/trouble.nvim",
            "nvim-telescope/telescope.nvim"
        },
        config = function()
            local cg = require("chatgpt")
            cg.setup({
                openai_params = {
                    model = "gpt-4o"
                    --model = "gpt-4-turbo"
                    --model = "gpt-4"
                    --model = "gpt-3.5-turbo"
                },
                actions_paths = {
                    "~/.config/nvim/chatgpt-actions.json"
                },
                popup_input = {
                    submit = "<C-Enter>",
                    submit_n = "<Enter>",
                },
            })

            require("which-key").register({
                mode = { 'v', 'n' },
                ["<Leader>a"] = {
                    name = "AI",
                    c = { "<cmd>ChatGPT<CR>", "ChatGPT" },
                    d = { "<cmd>ChatGPTRun docstring<CR>", "Docstring", mode = { "n", "v" } },
                    e = { "<cmd>ChatGPTEditWithInstruction<CR>", "Edit with instruction", mode = { "n", "v" } },
                    f = { "<cmd>ChatGPTRun fix_bugs<CR>", "Fix Bugs", mode = { "n", "v" } },
                    g = { "<cmd>ChatGPTRun grammar_correction<CR>", "Grammar Correction", mode = { "n", "v" } },
                    k = { "<cmd>ChatGPTRun keywords<CR>", "Keywords", mode = { "n", "v" } },
                    o = { "<cmd>ChatGPTRun optimize_code<CR>", "Optimize Code", mode = { "n", "v" } },
                    r = { "<cmd>ChatGPTRun code_readability_analysis<CR>", "Code Readability Analysis", mode = { "n", "v" } },
                    R = { "<cmd>ChatGPTRun roxygen_edit<CR>", "Roxygen Edit", mode = { "n", "v" } },
                    s = { "<cmd>ChatGPTRun summarize<CR>", "Summarize", mode = { "n", "v" } },
                    t = { "<cmd>ChatGPTRun my_add_tests<CR>", "Add Tests", mode = { "n", "v" } },
                    T = { "<cmd>ChatGPTRun translate<CR>", "Translate", mode = { "n", "v" } },
                    x = { "<cmd>ChatGPTRun explain_code<CR>", "Explain Code", mode = { "n", "v" } },
                },
                ["<Leader>c"] = {
                    name = "code",
                    ["c"] = { "<cmd>ChatGPTRun my_complete_code<CR>", "complete (ChatGPT)" }
                }
            })
        end,
    }
}
