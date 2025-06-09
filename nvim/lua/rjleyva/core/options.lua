-- Set leader key
vim.g.mapleader = " "

-- UI and interaction
vim.opt.mouse = "" -- disable mouse support
vim.opt.splitkeep = "cursor" -- keep split position centered on cursor
vim.opt.number = true -- show line numbers
vim.opt.relativenumber = true -- show relative line numbers
vim.opt.cursorline = false -- don't highlight the current line
vim.opt.title = true -- set terminal title
vim.opt.wrap = false -- disable line wrapping
vim.opt.breakindent = true -- enable break indent
vim.opt.showcmd = false -- don't show command in the last line
vim.opt.cmdheight = 0 -- hide the command line when not in use
vim.opt.laststatus = 2 -- always show status line
vim.opt.signcolumn = "yes" -- always show sign column
vim.opt.termguicolors = true -- enable true color support
vim.opt.background = "dark" -- set background to dark

-- Splits and windows
vim.opt.splitright = true -- vertical splits to the right
vim.opt.splitbelow = true -- horizontal splits below
vim.opt.scrolloff = 10 -- minimum lines above/below cursor

-- Indentation and tabs
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Search behavior
vim.opt.ignorecase = true -- ignore case by default
vim.opt.smartcase = true -- override ignorecase if uppercase used
vim.opt.hlsearch = true -- highlight search matches
vim.opt.inccommand = "split" -- show live preview of :substitute

-- File handling
vim.opt.backup = false -- no backup files
vim.opt.swapfile = false -- no swap files
vim.opt.shell = "zsh" -- use zsh as shell

-- Editing behavior
vim.opt.backspace = { "start", "eol", "indent" } -- allow backspace in insert mode
vim.opt.clipboard:append("unnamedplus") -- use system clipboard
vim.opt.formatoptions:append({ "r" }) -- continue comments with Enter

-- File navigation
vim.opt.path:append({ "**" }) -- search into subfolders
vim.opt.wildignore:append({ "*/node_modules/*" }) -- ignore node_modules in completions

-- Disable intro message
vim.opt.shortmess:append("I")

-- Disable built-in plugins
vim.g.loaded_gzip = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_tutor_mode_plugin = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Terminal italic support (for some themes or terminals)
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])
vim.cmd("set t_ZH=[3m")
vim.cmd("set t_ZR=[23m")
