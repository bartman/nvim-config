vim.cmd([[
syntax on
set expandtab tabstop=4 softtabstop=4 shiftwidth=4
set cmdheight=3 signcolumn=yes visualbell
set cursorline number numberwidth=5 "relativenumber
"set cursorline number relativenumber numberwidth=5
set shada=!,%100,'100,/100,h,<500,:100 history=200 " shada this replaces viminfo
set undofile undolevels=1000 updatecount=100 updatetime=10001
set modeline modelines=5 nomodelineexpr
set backup backupext=~
set scrolloff=5 sidescrolloff=5
set splitbelow splitright
set spell
]])

vim.g.mapleader = ","
vim.g.maplocalleader = "\\"
vim.g.editorconfig = true -- enable .editorconfig files
vim.wo.number = true

---------------------------------------------------------------------------
--  tags

vim.cmd([[
let $kernel_version=system('uname -r | tr -d "\n"')
let $debug_kernel_tags=system("ls -d /usr/src/debug/*/linux-$kernel_version/tags 2>/dev/null | head -n1 | tr -d '\n'")
set tags=./tags,tags,../tags,../../tags,../../../tags,../../../../tags,/lib/modules/$kernel_version/build/tags,$debug_kernel_tags,/usr/include/tags
]])
