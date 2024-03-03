-- this plugin uses ollama server to run an open source LLM
-- locally and get results from it.  to use it you will have
-- to have ollama installed, so do that first
-- https://github.com/ollama/ollama
return {
    -- https://github.com/David-Kunz/gen.nvim
    "David-Kunz/gen.nvim",
    config = function()
        local gen = require'gen'
        gen.setup({
            --model = "mistral",
            model = 'llama2:13b',

            -- 💫 https://ollama.com/library/starcoder2
            --model = "starcoder2:15b", -- 600+ languages
            --model = "starcoder2:7b", -- 17 languages

            --
            host = "localhost", -- The host running the Ollama service.
            port = "11434", -- The port on which the Ollama service is listening.
            display_mode = "split", -- The display mode. Can be "float" or "split".
            show_prompt = false, -- Shows the Prompt submitted to Ollama.
            show_model = false, -- Displays which model you are using at the beginning of your chat session.
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

        gen.prompts['Comment_To_Code'] = {
            prompt = "Using $filetype generate code for the following comment block:"
                    .. "$text\n"
            ,
        }
        gen.prompts['Comment_Replace_With_Code'] = {
            prompt = "Using $filetype generate code for the following comment block.  Support latest features of the language.  Add good comments to the code.  Only output the result in format ```$filetype\n...\n```:"
                    .. "```$filetype\n$text\n```\n"
            ,
            replace = true,
            extract = "```$filetype\n(.-)```"
        }
    end,
}
