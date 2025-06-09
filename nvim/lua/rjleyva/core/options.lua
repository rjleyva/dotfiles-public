vim.g.mapleader = " "

vim.opt.mouse = ""
vim.opt.splitkeep = "cursor"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = false
vim.opt.title = true
vim.opt.wrap = false
vim.opt.breakindent = true
vim.opt.showcmd = false
vim.opt.cmdheight = 0
vim.opt.laststatus = 2
vim.opt.signcolumn = "yes"
vim.opt.termguicolors = true
vim.opt.background = "dark"

vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.scrolloff = 10

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.inccommand = "split"

vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.shell = "zsh"

vim.opt.backspace = { "start", "eol", "indent" }
vim.opt.clipboard:append("unnamedplus")
vim.opt.formatoptions:append({ "r" })

vim.opt.path:append({ "**" })
vim.opt.wildignore:append({ "*/node_modules/*" })

vim.opt.shortmess:append("I")

vim.g.loaded_gzip = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_tutor_mode_plugin = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])
vim.cmd("set t_ZH=[3m")
vim.cmd("set t_ZR=[23m")
