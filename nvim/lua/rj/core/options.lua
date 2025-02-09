vim.cmd("let g:netrw_liststyle = 3")

vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

local opt = vim.opt -- for conciseness

vim.g.mapleader = " "

-- line numbers
vim.opt.relativenumber = true -- show relative line numbers
vim.opt.number = true -- shows absolute line number on cursor line (when relative number is on)

-- tabs & indentation
vim.opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
vim.opt.shiftwidth = 2 -- 2 spaces for indent width
vim.opt.expandtab = true -- expand tab to spaces
vim.opt.autoindent = true -- copy indent from current line when starting new one
vim.opt.smartindent = true

-- line wrapping
vim.opt.wrap = false -- disable line wrapping

-- search settings
vim.opt.ignorecase = true -- ignore case when searching
vim.opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

-- cursor line
vim.opt.cursorline = false -- highlight the current cursor line

-- appearance
vim.opt.laststatus = 0

-- turn on termguicolors for nightfly colorscheme to work
-- (have to use iterm2 or any other true color terminal)
vim.opt.termguicolors = true
vim.opt.background = "dark" -- colorschemes that can be light or dark will be made dark
vim.opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- backspace
vim.opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
vim.opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
vim.opt.splitright = true -- split vertical window to the right
vim.opt.splitbelow = true -- split horizontal window to the bottom

vim.opt.backup = false
vim.opt.showcmd = true
vim.opt.cmdheight = 1
vim.opt.scrolloff = 10
vim.opt.shell = "zsh"
vim.opt.hlsearch = true
vim.opt.splitkeep = "cursor"
vim.opt.mouse = ""

-- custom cursor terminal color
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

-- autocmds astro file type detection
vim.cmd([[au BufNewFile,BufRead *.astro setf astro]])

-- turn off swapfile
opt.swapfile = false

if vim.fn.has("nvim-0.8") == 1 then
  vim.opt.cmdheight = 0
end
