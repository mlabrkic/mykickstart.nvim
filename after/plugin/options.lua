------------------------- OPTIONS --------------------------
--[[
Setting options

h vim_diff.txt
h nvim-defaults

h option-list

https://github.com/nanotee/nvim-lua-guide#using-meta-accessors
help vim.opt
]]

-- local opt = vim.opt -- for conciseness

------------------------------------------------------------
-- https://github.com/folke/dot

-- vim.g.mapleader = " "
-- vim.g.maplocalleader = ","
-- vim.g.node_host_prog = "/Users/folke/.pnpm-global/5/node_modules/neovim/bin/cli.js"

-- ginit.vim  (guifont=SauceCodePro NF:h16)
-- vim.opt.guifont = "FiraCode Nerd Font:h12"
-- vim.opt.guifont = "monospace:h17" -- the font used in graphical neovim applications

------------------------------------------------------------
--[[
:options
--> Neovim\share\nvim\runtime\optwin.vim
--> "option-window" :
]]
------------------------------------------------------------
-- 1 important

vim.opt.cpoptions:remove { 'a' } -- template support

-- vim.cmd[[
-- " template support
-- set cpoptions-=a
-- ]]

-- :set cpoptions?

--[[
h cpoptions
def: cpoptions=aABceFs_  (list of flags to specify Vi compatibility - flags for Vi-compatible behavior)

h cpo-a
When included, a ":read" command with a file name argument
will set the alternate file name for the current window.

https://github.com/Happy-Dude/dotfiles
set cpoptions+=a        " :read updates alternative file name
set cpoptions+=A        " :write updates alternative file name
set cpoptions+=B        " A backslash has no special meaning in mappings
set cpoptions+=c        " Searching continues at the end of the match at the cursor position
set cpoptions+=e        " Automatically add <CR> to the last line when using :@r
set cpoptions+=F        " :write command updates current file name
set cpoptions+=s        " Set buffer options when entering the buffer
set cpoptions+=m        " When a new match is created (showmatch), pause for .5s
set cpoptions+=q        " When joining lines, leave the cursor

]]

------------------------------------------------------------
-- GUI:

--[[ neovim-qt wiki
https://github.com/equalsraf/neovim-qt/wiki#guifontguiforegroundetc-dont-exist

GuiFont/GuiForeground()/etc don't exist
:Gui, TAB

:echo exists('g:GuiLoaded')
or
lua print(vim.g.GuiLoaded)
==> 0

Likely means the neovim-gui-shim plugin is not being loaded,
check your &runtimepath it should include a nvim-qt folder in there.
echo &rtp

nvim_gui_shim.vim :
C:\UTILS\Neovim\share\nvim-qt\runtime\plugin\nvim_gui_shim.vim
]]

-- set &rtp to include the runtime folder
-- h rtp
-- vim.g.rtp:append 'C:/UTILS/Neovim/share/nvim-qt/runtime/' -- mlabrkic

------------------------------------------------------------
-- 2 moving around, searching and patterns

-- def: whichwrap=b,s  (allow specified keys to cross line boundaries)
vim.opt.whichwrap:append '<,>,[,]' -- allows wrap only when cursor keys are used.
-- incsearch -- show match for partly typed search command

-- Case insensitive searching UNLESS /C or capital in search
-- vim.opt.ignorecase = true    -- def: noignorecase  (ignore case in search patterns)
-- vim.opt.smartcase = true     -- def: nosmartcase  (no ignore case when pattern has uppercase)

------------------------------------------------------------
-- 3 tags

------------------------------------------------------------
-- 4 displaying text

-- vim.opt.display = ""         -- def: set dy=lastline,msgsep

vim.opt.scrolloff = 4 -- def: scrolloff=0  (Lines of context -number of screen lines to show around the cursor)
-- vim.opt.wrap = true       -- def: wrap  (long lines wrap and continue on the next line)
vim.opt.linebreak = true -- Line wrap without breaking words
vim.opt.showbreak = '↪' -- Character to show before the lines that have been soft-wrapped
-- vim.opt.breakindent = true   -- def: nobreakindent  (wrapped line repeats indent)

-- characters to use for the status line, folds and filler lines
-- vim.opt.fillchars = ""       -- def: set fcs= (Defaults (in effect) to "vert:│,fold:·,sep:│")
--[[
vim.opt.fillchars = {
  --   horiz = "━",
  --   horizup = "┻",
  --   horizdown = "┳",
  --   vert = "┃",
  --   vertleft = "┫",
  --   vertright = "┣",
  --   verthoriz = "╋",im.o.fillchars = [[eob: ,
  -- fold = " ",
  foldopen = "",
  -- foldsep = " ",
  foldclose = "",
}
]]

-- vim.opt.fillchars.eob=" "    -- show empty lines at the end of a buffer as ` ` {default `~`}
-- https://github.com/bfredl/bfredl.github.io
-- vim.opt.fillchars.eob=" "    -- show empty lines at the end of a buffer as ` ` {default `~`}
vim.opt.fillchars.eob = '█'

-- vim.opt.cmdheight = 2        -- def: cmdheight=1  (number of lines to use for the command-line)
vim.opt.lazyredraw = true -- def: nolazyredraw  (don't redraw while executing macros)

vim.opt.list = true -- def: nolist  (show <Tab> and <EOL>) - Show some invisible characters (tabs...

-- def: listchars=tab:> ,trail:-,nbsp:+  (characters for displaying in list mode)
-- set list listchars=tab:▸\ ,extends:❯,precedes:❮,nbsp:␣
vim.opt.listchars = { tab = '▸\\ ', extends = '❯', precedes = '❮', trail = '⣿', nbsp = '±' }
-- vim.opt.listchars = {tab = '▸ ', extends = '❯', precedes = '❮', trail = '⣿', nbsp = '±'}
-- vim.opt.listchars = {tab = '»·', extends = '❯', precedes = '❮', trail = '⣿', nbsp = '±'}

-- vim.opt.number = true        -- def: nonumber  (print the line number in front of each line)
vim.opt.relativenumber = true -- def: norelativenumber  (Relative line numbers)
-- vim.opt.numberwidth = 4      -- def: set nuw=4  (number of columns to use for the line number)

-- vim.opt.concealcursor = "nc" -- Hide * markup for bold and italic
-- vim.opt.conceallevel = 0     -- def: conceallevel  (so that `` is visible in markdown files)
-- vim.opt.conceallevel = 3 -- Hide * markup for bold and italic

-- minimal number of screen columns to keep to the left and right of the cursor if wrap is `false`
-- vim.opt.sidescrolloff = 8    -- def: sidescrolloff=0  (Columns of context)

------------------------------------------------------------
-- 5 syntax, highlighting and spelling

-- vim.opt.background = "dark"  -- def: "dark" (unless set automatically by the terminal/UI)

-- vim.opt.hlsearch = false  -- def: hlsearch  (highlight matches with last search pattern)

-- vim.opt.termguicolors = true  -- default:  termguicolors  (True color support- most terminals support this)
-- https://github.com/termstandard/colors
-- https://gist.github.com/XVilka/8346728.

-- vim.cmd [[
--   let g:gruvbox_material_background = 'hard'
--   " let g:gruvbox_material_better_performance = 1
--   " set background=dark
--   colorscheme gruvbox-material
-- ]]

vim.opt.cursorline = true -- def: nocursorline  (highlight the screen line of the cursor)

------------------------------------------------------------
-- 6 multiple windows

-- vim.opt.hidden = true        -- def: enabled (don't unload a buffer when no longer shown in a window)

-- vim.opt.laststatus = 3       -- only the last window will always have a status line
-- defaults to 2 (statusline is always shown)
-- laststatus  -- 0, 1, 2 or 3; when to use a status line for the last window: set ls=2
-- statusline  -- alternate format to be used for a status line: set stl=

-- vim.opt.hidden = true        -- def: hidden  (Enable modified buffers in background)
vim.opt.splitbelow = true -- def: nosplitbelow  (Put new windows below current)
vim.opt.splitright = true -- def: nosplitright  (Put new windows right of current)

------------------------------------------------------------
-- 7 multiple tab pages

-- vim.opt.showtabline = 0      -- always show tabs

------------------------------------------------------------
-- 8 terminal

------------------------------------------------------------
-- 9 using the mouse

-- vim.opt.mouse = 'a'       -- def: mouse=nvi  (enable the use of mouse clicks)

------------------------------------------------------------
-- 10 printing

------------------------------------------------------------
-- 11 messages and info

-- vim.o.shortmess = "IToOlxfitn"
-- vim.opt.shortmess:get()

-- def: shortmess=filnxtToOF   -- (list of flags to make messages shorter)
if vim.fn.has 'nvim-0.9' == 1 then
  vim.o.shortmess = 'filnxtToOFWIcC'
end

-- vim.opt.shortmess:append "c" -- hide all the completion messages, e.g. "-- XXX completion (YYY)", "match 1 of 2", "The only match", "Pattern not found"

--[[
https://github.com/jdhao/nvim-config

" Do not show "match xx of xx" and other messages during auto-completion
set shortmess+=c

" Do not show search match count on bottom right (seriously, I would strain my
" neck looking at it). Using plugins like vim-anzu or nvim-hlslens is a better
" choice, IMHO.
set shortmess+=S

" Disable showing intro message (:intro)
set shortmess+=I
]]

-- vim.opt.showcmd = false      -- show (partial) command keys in the status line:  set sc  nosc (for performance)
vim.opt.showmode = false -- def: showmode  (dont show mode since we have a statusline)

-- vim.opt.confirm = true -- confirm to save changes before exiting modified buffer
-- vim.opt.ruler = false        -- hide the line and column number of the cursor position

------------------------------------------------------------
-- 12 selecting text

-- https://stackoverflow.com/q/30691466/6064933
-- def: clipboard=  ("unnamed" to use the * register like unnamed register)
-- vim.opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard

------------------------------------------------------------
-- 13 editing text

-- vim.opt.backspace = "indent,eol,start"  -- def: "indent,eol,start" (specifies what <BS>, CTRL-W, etc. can do in Insert mode)

-- vim.opt.undofile = true      -- def: noundofile  (save undo information in a file -enable persistent undo)
vim.opt.undolevels = 10000 -- def: undolevels=1000

------------------------------
-- h formatoptions
-- defaults to "tcqj"
-- def: formatoptions=jcroql  (how automatic formatting is to be done)

-- vim.o.formatoptions = "jcroqlnt" -- tcqj

-- https://github.com/tjdevries/config_manager

-- vim.opt.formatoptions:remove "t"  -- don't autoformat
vim.opt.formatoptions:remove 'o' -- don't continue comments after o/O
-- vim.opt.formatoptions:remove({ "c", "r", "o" }) -- This is a sequence of letters which describes how automatic formatting is to be done

--[[
vim.opt.formatoptions = vim.opt.formatoptions
    + "r" -- continue comments after return
    + "c" -- wrap comments using textwidth
    + "q" -- allow to format comments w/ gq
    + "j" -- remove comment leader when joining lines when possible
    - "t" -- don't autoformat
    - "a" -- no autoformatting
    - "o" -- don't continue comments after o/O
    - "2" -- don't use indent of second line for rest of paragraph
]]

--[[
https://github.com/Happy-Dude/dotfiles
" Note: plugins may add their own format options on various filetypes
set formatoptions+=r    " r: automatically insert comment leader
set formatoptions+=w    " w: automatically insert leading whitespace
set formatoptions+=j    " j: delete comment character when joining commented lines
]]

-- https://github.com/glepnir/cosynvim
-- vim.opt.formatoptions = '1jcroql'

------------------------------

-- def: set cpt=.,w,b,u,t  (excludes "i")
-- vim.org.complete = ""        -- (specifies how Insert mode completion works for CTRL-N and CTRL-P)

-- vim.opt.completeopt = "menu,menuone,noselect"
-- vim.opt.completeopt = { "menuone", "noselect" } -- mostly just for cmp
-- vim.opt.completeopt = 'menuone,noselect'  -- def:  completeopt=menu,preview  (whether to use a popup menu for Insert mode completion)

vim.opt.pumblend = 10 -- def: pumblend=0  (Popup blend -pseudo transparency for completion menu)
vim.opt.pumheight = 10 -- def: pumheight=0  (Maximum number of entries in a popup menu)

vim.opt.showmatch = true -- def: noshowmatch  (briefly jump to matching bracket if insert one)

-- def: matchpairs=(:),{:},[:]  (pairs of characters that "%" can match)
vim.opt.matchpairs:append '<:>' -- pairs for % command

-- vim.cmd[[
-- set matchpairs+=<:> " pairs for % command
-- ]]

-- vim.opt.joinspaces = false   -- def: nojoinspaces  (No double spaces with join after a dot)

------------------------------------------------------------
-- 14 tabs and indenting

-- vim.opt.autoindent = true    -- def: enabled (automatically set the indent of a new line)

vim.opt.tabstop = 2 -- def: tabstop=8  (number of spaces that <Tab> in file uses)
vim.opt.shiftwidth = 2 -- def: shiftwidth=8  (number of spaces to use for (auto)indent step) - Size of an indent
-- set smarttab            " A <Tab> in front of a line inserts blanks according to settings; <BS> deletes a shiftwidth
-- def: softtabstop=0  (number of spaces that <Tab> uses while editing)

-- https://github.com/Happy-Dude/dotfiles
-- (Round indent -round to 'shiftwidth' for "<<" and ">>")
vim.opt.shiftround = true -- def: noshiftround  (When at 3 spaces and hit > ... go to 4, not 5)

vim.opt.expandtab = true -- def: noexpandtab  (use spaces when <Tab> is inserted)
-- vim.opt.smartindent = true   -- def: nosmartindent  (Insert indents automatically)

------------------------------------------------------------
-- 15 folding

--[[
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()" -- TreeSitter folding
-- vim.opt.foldlevel = 6
-- vim.opt.foldmethod = "expr" -- TreeSitter folding
-- vim.opt.foldmethod = "indent"
-- vim.opt.foldlevel = 0
]]

------------------------------------------------------------
-- 16 diff mode

------------------------------------------------------------
-- 17 mapping

-- vim.opt.timeoutlen = 1000    -- time to wait for a mapped sequence to complete (in milliseconds)

------------------------------------------------------------
-- 18 reading and writing files

-- vim.opt.autoread = true      -- def: enabled (automatically read a file when it was modified outside of Vim)
-- vim.opt.backupdir = ""    -- def: set bdir=.,C:\\Users\\<username>\\AppData\\Local\\nvim-data\\backup\\\\

-- modeline -- enable using settings from modelines when reading a file (local to buffer): set ml  noml
-- modelineexpr -- allow setting expression options from a modeline: set nomle mle
-- modelines  -- number of lines to check for modelines: set mls=5

-- vim.opt.autowrite = true -- enable auto write
-- vim.opt.backup = false       -- creates a backup file
-- vim.opt.writebackup = false     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited

------------------------------------------------------------
-- 19 the swap file

-- faster completion (4000ms default) (for responsive async plugins like signify and coc)
-- vim.opt.updatetime = 250     -- def: updatetime=4000  (milliseconds, save swap file and trigger CursorHold events)
-- vim.opt.swapfile = false     -- creates a swapfile

------------------------------------------------------------
-- 20 command line editing

-- vim.opt.history = ""         -- defaults to 10000 (the maximum)

vim.opt.wildmode = 'longest:full,full' -- def: wildmode=full  (Command-line completion mode)

--[[
" Ignore this list of file extensions
" */ for ctrlp globbing
set wildignore=*/.bak
set wildignore+=*/.sw?                                  " Vim swap files
set wildignore+=*/.DS_Store                             " OS X bullshit
set wildignore+=*/.spl                                  " Compiled spelling word lists
set wildignore+=*/.bmp,*/.gif,*/.jpg,*/.jpeg,*/.png     " Binary images
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*               " Version control
set wildignore+=*/.orig                                 " Merge resolution files
set wildignore+=*/.dll,*/.exe,*/.o,*/.obj,*/.manifest   " Compiled object files
set wildignore+=*/.pyc                                  " Python byte code
set wildignore+=migrations                              " Django migrations
set wildignore+=*/.luac                                 " Lua byte code
set wildignore+=*/.aux,*/.out,*/.toc                    " LaTeX intermediate files
]]

------------------------------------------------------------
-- 21 executing external commands

-- https://github.com/williamboman/nvim-config
-- if vim.fn.has "win32" == 1 then
--     vim.o.shell = "powershell.exe"
-- end

-- :lua print(vim.fn.has "win32")

------------------------------------------------------------
-- 22 running make and jumping to errors (quickfix)

-- h grepprg

-- bfredl:  rg --vimgrep --no-heading
-- vim.opt.grepprg = "rg --vimgrep --no-heading --smart-case"
-- vim.opt.grepformat = "%f:%l:%c:%m,%f:%l:%m"

vim.opt.grepprg = 'rg --vimgrep' -- def: grepprg=findstr /n $* nul  (program to use for ":grep")
vim.opt.grepformat = '%f:%l:%c:%m' -- def: grepformat=%f:%l:%m,%f:%l%m,%f  %l%m  (format of 'grepprg' output)

--[[
https://github.com/jdhao/nvim-config

" External program to use for grep command
if executable('rg')
  set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
  set grepformat=%f:%l:%c:%m
endif
]]

------------------------------------------------------------
-- 23 system specific

------------------------------------------------------------
-- 24 language specific

-- vim.opt.langremap = true     -- def: disabled (apply 'langmap' to mapped characters)

vim.opt.iskeyword:append '-' -- def: iskeyword=@,48-57,_,192-255  (characters included in keywords)

------------------------------------------------------------
-- 25 multi-byte characters

-- vim.opt.encoding = ""        -- def: set enc=utf-8 (character encoding used in Nvim: "utf-8")
-- vim.opt.fileencoding = "utf-8"  -- def: set fenc=utf-8 (character encoding for the current file)

------------------------------------------------------------
-- 26 various

-- def: sessionoptions=blank,buffers,curdir,folds,help,tabpages,winsize,terminal
vim.opt.sessionoptions = { 'buffers', 'curdir', 'tabpages', 'winsize' } -- (list of words that specifies what to put in a session file)

-- Always show the signcolumn, otherwise it would shift the text each time
-- vim.opt.signcolumn = 'yes'   -- def: signcolumn=auto  (when and how to display the sign column)

------------------------------------------------------------
------------------------------------------------------------
--[[
https://github.com/nvim-lua/kickstart.nvim
https://github.com/VonHeikemen/nvim-starter/tree/05-modular

https://github.com/folke/dot

-- ChristianChiarulli
https://github.com/LunarVim/nvim-basic-ide

https://github.com/jdhao/nvim-config
https://github.com/Happy-Dude/dotfiles
]]

------------------------------------------------------------
-- https://github.com/LunarVim/nvim-basic-ide
-- ChristianChiarulli

--[[
if vim.fn.has("nvim-0.8") == 1 then
  --   vim.opt.spell = true -- Put new windows below current
  vim.opt.cmdheight = 0

  -- make all keymaps silent by default
  local keymap_set = vim.keymap.set
  vim.keymap.set = function(mode, lhs, rhs, opts)
    opts = opts or {}
    opts.silent = opts.silent ~= false
    return keymap_set(mode, lhs, rhs, opts)
  end
end
]]

if vim.fn.has 'nvim-0.9.0' == 1 then
  vim.opt.splitkeep = 'screen'
end

------------------------------
-- vim.opt.inccommand = "nosplit" -- def: inccommand=nosplit  (preview incremental substitute)

-- if vim.fn.has("nvim-0.8") == 1 then
-- end

------------------------------------------------------------
-- Global Variable

-- don't load the plugins below
local builtins = {
  'gzip',
  'zip',
  'zipPlugin',
  'fzf',
  'tar',
  'tarPlugin',
  'getscript',
  'getscriptPlugin',
  'vimball',
  'vimballPlugin',
  '2html_plugin',
  'matchit',
  'matchparen',
  'logiPat',
  'rrhelper',
  'netrw',
  'netrwPlugin',
  'netrwSettings',
  'netrwFileHandlers',
}

for _, plugin in ipairs(builtins) do
  vim.g['loaded_' .. plugin] = 1
end

------------------------------
-- Use proper syntax highlighting in code blocks
local fences = {
  'lua',
  -- "vim",
  'json',
  'typescript',
  'javascript',
  'js=javascript',
  'ts=typescript',
  'shell=sh',
  'python',
  'sh',
  'console=sh',
}
vim.g.markdown_fenced_languages = fences
vim.g.markdown_recommended_style = 0

------------------------------
-- https://github.com/jdhao/nvim-config
-- jdhao\nvim-config\core\globals.lua

vim.cmd [[

" Custom variables
let g:is_win = (has('win32') || has('win64')) ? v:true : v:false
let g:is_linux = (has('unix') && !has('macunix')) ? v:true : v:false
let g:is_mac = has('macunix') ? v:true : v:false
let g:logging_level = 'info'

" Path to Python 3 interpreter (must be an absolute path), make startup
" faster. See https://neovim.io/doc/user/provider.html.
"
" For Python plugins you need the pynvim module.
" activate_venv_neovim.bat
" pip install pynvim
if executable('python')
   if g:is_win
    let g:python3_host_prog=substitute(exepath('python'), '.exe$', '', 'g')  " mlabrkic 2024_01M_16
    " let g:python3_host_prog = 'C:\UTILS\PORT\venvs_py\venv_neovim\Scripts\python.exe'
  elseif g:is_linux || g:is_mac
    let g:python3_host_prog=exepath('python')
  endif
else
  echoerr 'Python 3 executable not found! You must install Python 3 and set its PATH correctly!'
endif

" :echo expand(g:python3_host_prog)
" Paste last command: (Insert mode) CTRL-R :

" Use English as main language
" language en_US.utf-8

" ------------------------------
" TODO: What is this for?

" Whether to load netrw by default, see
" https://github.com/bling/dotvim/issues/4
" let g:loaded_netrw       = 0
" let g:loaded_netrwPlugin = 0
let g:netrw_liststyle = 3
if g:is_win
  let g:netrw_http_cmd = 'curl --ssl-no-revoke -Lo'
endif

]]

------------------------------------------------------------
