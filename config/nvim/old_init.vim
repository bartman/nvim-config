syntax on
filetype plugin indent on

"let mapleader = ','
let maplocalleader=','

if has("termguicolors")
    " this used to check for ($COLORTERM == 'truecolor'), but was not passing with tmux
    " && $COLORTERM == 'truecolor')
    set termguicolors
endif

set tabstop=8 expandtab
set shiftwidth=4 softtabstop=4
set autoindent smartindent
set cmdheight=2 signcolumn=yes visualbell
set cursorline number relativenumber numberwidth=5
set shada=!,%100,'100,/100,h,<500,:100 history=200
set backup backupext=~
set undofile undolevels=1000 updatecount=100 updatetime=10001
set wildmenu wildignore+=*.so,*.so.*,*.o,*.ko,*.a,.*,*.swp,*.zip,*.mod.c,*~,*.dep,*.d
set scrolloff=5 sidescrolloff=5
set nomodeline

set splitbelow splitright

" ---------------------------------------------------------------------------

let g:NERDCreateDefaultMappings = 1

" disable netrw (for nvim-tree compatibility)
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

let g:mwDefaultHighlightingPalette = 'maximum'

"let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#left_sep = '|'
"let g:airline#extensions#tabline#left_alt_sep = '|'
"let g:airline#extensions#tabline#formatter = 'default'

" for Shougo/deoplete.nvim
"    pip3 install --user pynvim
"let g:deoplete#enable_at_startup = 1

" ------------------------------------------------------------------------------
" for dense-analysis/ale

let g:ale_fixers = {
            \ 'c':   ['clang-format', 'clangtidy'],
            \ 'cpp': ['clang-format', 'clangtidy'],
            \ '*':   ['remove_trailing_lines', 'trim_whitespace'],
            \}
let g:ale_linters = {
            \ 'c':   ['clangd', 'clangtidy'],
            \ 'cpp': ['clangd', 'clangtidy'],
            \}
let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 1
let g:ale_completion_autoimport = 1
let g:ale_set_balloons = 1
let g:ale_c_clangd_executable = 'clangd-14'
let g:ale_cpp_clangd_executable = 'clangd-14'
let g:ale_c_clangtidy_executable = 'clang-tidy-14'
let g:ale_cpp_clangtidy_executable = 'clang-tidy-14'
let g:ale_c_clangformat_executable = 'clang-format-14'
let g:ale_cpp_clangformat_executable = 'clang-format-14'

let g:ale_c_parse_compile_commands = 1
let g:ale_c_build_dir_names = [ 'build']

"let g:ale_floating_preview = 1
let g:ale_floating_window_border = ['│', '─', '╭', '╮', '╯', '╰']
let g:ale_hover_to_floating_preview = 1
"let g:ale_detail_to_floating_preview = 1
"let g:ale_cursor_detail = 1

"let g:ale_echo_msg_error_str = ''
"let g:ale_echo_msg_warning_str = ''
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
"let g:ale_linters_explicit = 1

let g:ale_completion_symbols = {
    \ 'text': '',
    \ 'method': '',
    \ 'function': '',
    \ 'constructor': '',
    \ 'field': '',
    \ 'variable': '',
    \ 'class': '',
    \ 'interface': '',
    \ 'module': '',
    \ 'property': '',
    \ 'unit': 'v',
    \ 'value': 'v',
    \ 'enum': '#',
    \ 'keyword': 'v',
    \ 'snippet': 'v',
    \ 'color': 'v',
    \ 'file': 'v',
    \ 'reference': 'v',
    \ 'folder': 'v',
    \ 'enum_member': '#',
    \ 'constant': 'm',
    \ 'struct': 't',
    \ 'event': 'v',
    \ 'operator': 'f',
    \ 'type_parameter': 'p',
    \ '<default>': 'v'
    \ }



"set completeopt=menu,menuone,preview,noselect,noinsert
set completeopt=menu,menuone,popup,noselect,noinsert

"set completeopt=menu,menuone,preview,noselect,noinsert
"set omnifunc=ale#completion#OmniFunc

" for syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" for minimap

" ---------------------------------------------------------------------------
" https://github.com/junegunn/vim-plug?tab=readme-ov-file#unix-linux
call plug#begin()

" ... utilities ...

"Plug 'preservim/nerdtree'                   " :NERDTree
"Plug 'kien/ctrlp.vim'

Plug 'akinsho/toggleterm.nvim'              " :ToggleTerm

Plug 'nvim-tree/nvim-tree.lua'              " :NvimTreeOpen
Plug 'nvim-tree/nvim-web-devicons'          " icons for nvim-tree

Plug 'preservim/tagbar'                     " :Tagbar

Plug 'godlygeek/tabular'                    " :Tabularize

Plug 'windwp/nvim-autopairs'
Plug 'chrisbra/matchit'                     " %
"Plug 'editorconfig/editorconfig-vim'        " .editorconfig file parser -- disabled, already enabled in nvim

Plug 'inkarkat/vim-ingo-library'            " required by mark
Plug 'inkarkat/vim-mark'                    " :Mark

Plug 'winston0410/cmd-parser.nvim'          " required by range-highlight
Plug 'winston0410/range-highlight.nvim'     " BROKEN: highight :N,M ranges
"Plug 'Mr-LLLLL/interestingwords.nvim'       " BROKEN: highlight multiple searches

"Plug 'vim-syntastic/syntastic'              " show build errors

Plug 'chrisbra/vim-diff-enhanced'           " :PatienceDiff :EnhancedDiff

Plug 'wfxr/minimap.vim'                     " :Minimap

Plug 'ypcrts/securemodelines'               " filter modelines

" ... fuzzy finder ...

" this requires fzf command to be available in shell
" clone https://github.com/junegunn/fzf.git into ~/src/fzf, run ./install
"Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
"Plug 'junegunn/fzf.vim'                     " :FZF :Files

" this is a native implementation with no dependencies, it uses rg
Plug 'nvim-lua/plenary.nvim'                " needed by telescope
Plug 'nvim-telescope/telescope.nvim'        " :Telescope
"Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
"^^^ getting warnings when loading

"Plug 'preservim/nerdcommenter'
Plug 'tpope/vim-commentary'                 " gc,gcc,gcap for commenting stuff out
Plug 'tpope/vim-surround'                   " lots of stuff

" ... completion ...

"Plug 'neoclide/coc.nvim'
"Plug 'jiangmiao/auto-pairs'                " sutpid, almost never what I want

"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'dense-analysis/ale'

" ... git ...

Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'

" ... syntax ...

Plug 'bfrg/vim-cpp-modern'
Plug 'vim-scripts/Mixed-sourceassembly-syntax-objdump'  " ft=cmix

Plug 'vim-pandoc/vim-pandoc-syntax'         " markdown syntax highligting

" ... colorschemes ...

"Plug 'felixhummel/setcolors.vim'
Plug 'flazz/vim-colorschemes'
Plug 'rktjmp/lush.nvim'
"Plug 'rebelot/kanagawa.nvim'
"Plug 'catppuccin/nvim'                      " need neser nvim
"Plug 'gruvbox-community/gruvbox'
"Plug 'kaicataldo/material.vim'
"Plug 'dracula/vim'
"Plug 'sickill/vim-monokai'

" ... eye candy ...

"Plug 'nvim-tree/nvim-web-devicons'

" icons for nerdtree
Plug 'ryanoasis/vim-devicons'

"Plug 'bling/vim-bufferline'
"Plug 'vim-airline/vim-airline-themes'
"Plug 'vim-airline/vim-airline'
"Plug 'famiu/feline.nvim'
"Plug 'ojroques/nvim-hardline'
Plug 'nvim-lualine/lualine.nvim'

call plug#end()

" ---------------------------------------------------------------------------
" colorscheme

colo Dark2
"colo darkbone
"colo antares
"colo Black
"colo ayu
"colo ubaryd
"colo burnttoast256
"colo clearance

"colo Atelier_ForestDark
"colo Atelier_HeathDark
"colo Atelier_SeasideDark
"colo boa
"colo mushroom
"colo mustang
"colo whitebox

:hi CursorLine cterm=underline guibg=#111111

:hi VertSplit  cterm=reverse ctermfg=236 ctermbg=249 gui=reverse guifg=#353535 guibg=#bbbbbb
:hi SignColumn cterm=reverse ctermfg=236 ctermbg=249 gui=reverse guifg=#353535 guibg=#bbbbbb

:hi LineNrAbove   ctermfg=241 ctermbg=233 guifg=#776462 guibg=#1c1b1a
:hi LineNr        ctermfg=241 ctermbg=233 guifg=#888888 guibg=#1c1b1a
:hi CursorLineNr  ctermfg=241 ctermbg=233 guifg=#888888 guibg=#1c1b1a
:hi LineNrBelow   ctermfg=241 ctermbg=233 guifg=#666477 guibg=#1c1b1a

:hi Comment     ctermfg=14 guifg=#886644
:hi PreProc     ctermfg=83 guifg=#77AA77
:hi cTodo       ctermfg=Red guifg=#FF0000

:hi cCharacter     ctermfg=10 guifg=Orange2
:hi link cConstant cDefine

:hi cppOperator    ctermfg=Blue guifg=#8888EE
:hi cppBoolean     ctermfg=Blue guifg=#8888EE
:hi cppConstant    ctermfg=Blue guifg=#8888EE
:hi cppRawString   ctermfg=Blue guifg=#8888EE
:hi cppNumber      ctermfg=Blue guifg=#8888EE
:hi cppFloat       ctermfg=Blue guifg=#8888EE
:hi cppNumbers     ctermfg=Blue guifg=#8888EE

:hi SpellBad    ctermbg=Red gui=underline guisp=Red guibg=#440000

:hi QuickFixLine ctermbg=Red guibg=#440000

" ---------------------------------------------------------------------------
"  tags

let $kernel_version=system('uname -r | tr -d "\n"')
let $debug_kernel_tags=system("ls -d /usr/src/debug/*/linux-$kernel_version/tags 2>/dev/null | head -n1 | tr -d '\n'")
set tags=./tags,tags,../tags,../../tags,../../../tags,../../../../tags,/lib/modules/$kernel_version/build/tags,$debug_kernel_tags,/usr/include/tags


" ---------------------------------------------------------------------------
" NERDTree

"nnoremap <c-n> <Esc>:NERDTreeToggle<cr>
"nnoremap <c-b> <Esc>:TagbarToggle<cr>
nnoremap <c-n> <Esc>:NvimTreeToggle<cr>
nnoremap <Esc>n <Esc>:NvimTreeFindFileToggle<cr>

nnoremap <c-b> <Esc>:TagbarToggle<cr>

" ---------------------------------------------------------------------------
" FZF/telescope

nnoremap <C-p> <Esc>:Telescope<cr>
nnoremap <LocalLeader>ff <cmd>Telescope find_files<cr>
nnoremap <LocalLeader>fg <cmd>Telescope live_grep<cr>
nnoremap <LocalLeader>fb <cmd>Telescope buffers<cr>
nnoremap <LocalLeader>fh <cmd>Telescope help_tags<cr>

" ---------------------------------------------------------------------------
" Minimap

map <LocalLeader>mm <Esc>:MinimapToggle<cr>

" ---------------------------------------------------------------------------
" Mark

map <LocalLeader>ms <Plug>MarkSet
map <LocalLeader>mc <Plug>MarkClear

" ---------------------------------------------------------------------------
" markdown syntax via vim-pandoc/vim-pandoc-syntax plugin

augroup pandoc_syntax
    au! BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
augroup END

" ---------------------------------------------------------------------------
" completion deoplete and ale

"call deoplete#custom#option('sources', {'_': ['ale'],})

" ---------------------------------------------------------------------------
"  toggleterm

autocmd TermEnter term://*toggleterm#*
      \ tnoremap <silent><c-q> <Cmd>exe v:count1 . "ToggleTerm"<CR>

nnoremap <silent><c-q> <Cmd>exe v:count1 . "ToggleTerm"<CR>
inoremap <silent><c-q> <Esc><Cmd>exe v:count1 . "ToggleTerm"<CR>

" ---------------------------------------------------------------------------
" git

"ca git Git

map <LocalLeader>gs :Git<cr>
map <LocalLeader>gd :Gdiffsplit<cr>
map <LocalLeader>gc :Gcommit<cr>
map <LocalLeader>gb :Git blame<cr>
map <LocalLeader>gl :Gclog<cr>
map <LocalLeader>gg :copen<CR>:Ggrep -e '<C-R>=getreg('/')<Enter>'<CR>

" git gutter

let g:gitgutter_diff_args = "--ignore-submodules=all"

nmap <LocalLeader>gu :GitGutter<cr>

nmap [g :GitGutterPrevHunk<cr>
nmap ]g :GitGutterNextHunk<cr>

nmap <LocalLeader>ga :GitGutterStageHunk<cr>
nmap <LocalLeader>gr :GitGutterUndoHunk<cr>
nmap <LocalLeader>gp :GitGutterPreviewHunk<cr>

nmap <LocalLeader>gf :GitGutterFold<cr>

" navigate chunks of current buffer
"nmap [g <Plug>(coc-git-prevchunk)
"nmap ]g <Plug>(coc-git-nextchunk)

" navigate conflicts of current buffer
"nmap [c <Plug>(coc-git-prevconflict)
"nmap ]c <Plug>(coc-git-nextconflict)

" show chunk diff at current position
"nmap gs <Plug>(coc-git-chunkinfo)

" show commit contains current position
""nmap gc <Plug>(coc-git-commit)

" create text object for git chunks
"omap ig <Plug>(coc-git-chunk-inner)
"xmap ig <Plug>(coc-git-chunk-inner)
"omap ag <Plug>(coc-git-chunk-outer)
"xmap ag <Plug>(coc-git-chunk-outer)

" disable editorconfig for scp and fugitive buffers, git commit bufers

let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']
au FileType gitcommit let b:EditorConfig_disable = 1

" When leaving a buffer, save the cursor position
au BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

" When entering a buffer, restore the cursor position
function! MyWinSaveView()
        if &diff
                let b:winview = winsaveview()
        endif
endf
function! MyWinRestoreView()
        if &diff
                if(exists('b:winview'))
                        call winrestview(b:winview)
                endif
        endif
endf
au BufLeave * :call MyWinSaveView()
au BufEnter * :call MyWinRestoreView()

" ,hi - show what hilight is active at cursor {{{
function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
nnoremap <LocalLeader>hi :call SynStack()<CR>
"}}}

" ,so - reload configuration
nnoremap <LocalLeader>so :source $MYVIMRC<CR>

" find merge conflict markers
:map <LocalLeader>fc /\v^[<\|=>]{7}( .*\|$)<CR>

" ---------------------------------------------------------------------------
lua << END
-- require('feline').setup {}
-- require('hardline').setup {}
require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = 'dracula',
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        disabled_filetypes = {
            statusline = {},
            winbar = {},
            },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
            }
        },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        -- lualine_c = { lualine_filename },
        lualine_c = {
                {
                    'filename',
                    colored = true,
                    file_status = true,         -- Displays file status (readonly status, modified status)
                    newfile_status = true,      -- Display new file status (new file means no write after created)
                    path = 1,                   -- 0: Just the filename
                                                -- 1: Relative path
                                                -- 2: Absolute path
                                                -- 3: Absolute path, with tilde as the home directory
                                                -- 4: Filename and parent dir, with tilde as the home directory

                    shorting_target = 40,       -- Shortens path to leave 40 spaces in the window
                                                -- for other components. (terrible name, any suggestions?)
                    symbols = {
                        modified = '🖋️',        -- [+] Text to show when the file is modified.
                        readonly = '🔍',        -- [-] Text to show when the file is non-modifiable or readonly.
                        unnamed = '⁉️',          -- Text to show for unnamed buffers.
                        newfile = '🌟',         -- Text to show for newly created file before first write
                    },
                }
            },
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
        },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { { 'filename', path = 1 } },
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
        },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = { 'quickfix', 'nerdtree', 'fugitive', 'man', 'toggleterm' }
    }
require('range-highlight').setup{}
require('telescope').setup {

    extensions = {
        fzf = {
            fuzzy = true,                    -- false will only do exact matching
            override_generic_sorter = true,  -- override the generic sorter
            override_file_sorter = true,     -- override the file sorter
            case_mode = "smart_case",        -- or "ignore_case" or "respect_case" the default case_mode is "smart_case"
        }
    }
}

require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})

require("nvim-autopairs").setup {}

require("toggleterm").setup{}

--require('telescope').load_extension('fzf')
--[[
require("interestingwords").setup {
    colors = { '#aeee00', '#ff0000', '#0000ff', '#b88823', '#ffa724', '#ff2c4b' },
    search_count = true,
    navigation = true,
    search_key = "<leader>m",
    cancel_search_key = "<leader>M",
    color_key = "<leader>k",
    cancel_color_key = "<leader>K",
}
--]]

local function alternate_file()
    local current_file = vim.api.nvim_buf_get_name(0)
    local alternate_file

    if string.match(current_file, "%.cpp$") then
        alternate_file = string.gsub(current_file, "%.cpp$", ".hpp")
    elseif string.match(current_file, "%.hpp$") then
        alternate_file = string.gsub(current_file, "%.hpp$", ".cpp")
    elseif string.match(current_file, "%.c$") then
        alternate_file = string.gsub(current_file, "%.c$", ".h")
    elseif string.match(current_file, "%.h$") then
        alternate_file = string.gsub(current_file, "%.h$", ".c")
    else
        print("Not a C/C++ source or header file")
        return
    end

    -- Check if the alternate file exists
    local f = io.open(alternate_file, "r")
    if f then
        io.close(f)
        vim.api.nvim_command('edit ' .. alternate_file)
    else
        print("Alternate file does not exist: " .. alternate_file)
    end
end
vim.api.nvim_create_user_command('A', alternate_file, {})
END

" lualine changes the colours for the completions menu "

:hi Pmenu         ctermfg=241    ctermbg=233 guifg=#888888 guibg=#1c1b1a
:hi PmenuSel      ctermfg=yellow ctermbg=red guifg=#FFFF00 guibg=#AA0000
:hi PmenuSbar     ctermfg=black  ctermbg=233 guifg=#444444 guibg=#1c1b1a
:hi PmenuThumb    ctermfg=white  ctermbg=233 guifg=#AAAAAA guibg=#1c1b1a

:hi PmenuExtra    ctermfg=241    ctermbg=233 guifg=#AAAAAA guibg=#1c1b1a
:hi PmenuExtraSel ctermfg=yellow ctermbg=red guifg=#FFFF00 guibg=#AA0000

:hi PmenuKind     ctermfg=241    ctermbg=233 guifg=#FFFF00 guibg=#1c1b1a
:hi PmenuKindSel  ctermfg=yellow ctermbg=red guifg=#FFFF00 guibg=#AA0000
