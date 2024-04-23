-- lazy package install
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- this line loads ~/.config/nvim/lua/vim-options.lua
require("vim-options")

-- my functions
require("my-functions")

-- load in my-autocmds
require("my-autocmds")

-- this line tells lazy to load ~/.config/nvim/lua/plugins/*.lua
require("lazy").setup("plugins", {
    change_detection = {
        notify = false,
    },
    ui = {
        border = 'rounded',
    },
})
