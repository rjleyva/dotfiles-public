vim.g.mapleader = " "
vim.opt.mouse = ""
vim.opt.splitkeep = "cursor"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.cursorline = false
vim.opt.laststatus = 0
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.signcolumn = "yes"
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.backup = false
vim.opt.showcmd = true
vim.opt.cmdheight = 1
vim.opt.scrolloff = 10
vim.opt.hlsearch = true
vim.opt.swapfile = false
vim.opt.shell = "zsh"
vim.opt.backspace = "indent,eol,start"
vim.opt.clipboard:append("unnamedplus")

vim.opt.shortmess:append("I")
vim.opt.formatoptions:append({ "r" })

vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

vim.cmd("set t_ZH=[3m")
vim.cmd("set t_ZR=[23m")
