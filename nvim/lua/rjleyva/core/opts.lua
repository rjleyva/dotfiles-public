-- Leader key
vim.g.mapleader = ' '

-- General UI
vim.opt.background = 'dark'
vim.opt.breakindent = true
vim.opt.cmdheight = 0
vim.opt.cursorline = false
vim.opt.laststatus = 0
vim.opt.number = true
vim.opt.numberwidth = 3
vim.opt.relativenumber = true
vim.opt.scrolloff = 8
vim.opt.showcmd = false
vim.opt.showmode = false
vim.opt.signcolumn = 'yes:1'
vim.opt.statuscolumn = '%l%s'
vim.opt.termguicolors = true
vim.opt.title = true
vim.opt.wrap = false

-- Mouse and splits
vim.opt.mouse = ''
vim.opt.splitbelow = true
vim.opt.splitkeep = 'cursor'
vim.opt.splitright = true

-- Tabs and indentation
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.tabstop = 2

-- Search
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.inccommand = 'split'
vim.opt.smartcase = true

-- Spell, timeout, and list chars
vim.opt.list = true
vim.opt.spelllang = { 'en' }
vim.opt.timeoutlen = vim.g.vscode and 1000 or 300

-- Command and path behavior
vim.opt.clipboard:append 'unnamedplus'
vim.opt.formatoptions:append { 'r' }
vim.opt.path:append { '**' }
vim.opt.shortmess:append 'I'
vim.opt.wildignore:append { '*/node_modules/*' }
vim.opt.wildmode = 'longest:full,full'

-- File handling
vim.opt.backspace = { 'start', 'eol', 'indent' }
vim.opt.backup = false
vim.opt.shell = 'zsh'
vim.opt.swapfile = false

-- Global variables
vim.g.deprecation_warnings = true

-- Disable unused built-in plugins
vim.g.loaded_2html_plugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_tutor_mode_plugin = 1
vim.g.loaded_zipPlugin = 1

-- Copied from craftzdog GitHub repository
-- Terminal styling tweaks (italics, underlinea)
vim.cmd [[let &t_Cs = "\e[4:3m"]]
vim.cmd [[let &t_Ce = "\e[4:0m"]]
vim.cmd 'set t_ZH=[3m'
vim.cmd 'set t_ZR=[23m'
