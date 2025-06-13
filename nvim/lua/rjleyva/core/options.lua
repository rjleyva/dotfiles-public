vim.g.mapleader = " "

-- UI settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 3
vim.opt.cursorline = false
vim.opt.signcolumn = "yes:1"
vim.opt.statuscolumn = "%l%s"
vim.opt.title = true
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.wrap = false
vim.opt.breakindent = true
vim.opt.showcmd = false
vim.opt.cmdheight = 0
vim.opt.laststatus = 0
vim.opt.scrolloff = 10

-- Mouse and split behavior
vim.opt.mouse = ""
vim.opt.splitkeep = "cursor"
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Tabs and indentation
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.inccommand = "split"

-- File handling
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.shell = "zsh"
vim.opt.backspace = { "start", "eol", "indent" }

-- Command and path behavior
vim.opt.shortmess:append("I")
vim.opt.clipboard:append("unnamedplus")
vim.opt.formatoptions:append({ "r" })
vim.opt.path:append({ "**" })
vim.opt.wildignore:append({ "*/node_modules/*" })

-- Disable unused built-in plugins
vim.g.loaded_gzip = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_tutor_mode_plugin = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Terminal styling (italic + underline tweaks)
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])
vim.cmd("set t_ZH=[3m")
vim.cmd("set t_ZR=[23m")
