local M = {}

function M.leader()
  vim.g.mapleader = ' '
  vim.g.maplocalleader = '\\'
end

function M.ui()
  vim.opt.cmdheight = 1
  vim.opt.cursorline = false
  vim.opt.laststatus = 3
  vim.opt.number = true
  vim.opt.numberwidth = 3
  vim.opt.relativenumber = true
  vim.opt.scrolloff = 8
  vim.opt.showcmd = true
  vim.opt.showmode = true
  vim.opt.signcolumn = 'yes:1'
  vim.opt.termguicolors = true
  vim.opt.title = true
  vim.opt.wrap = false
  vim.opt.conceallevel = 0
  vim.opt.hidden = true
  vim.opt.updatetime = 300
end

function M.splits()
  vim.opt.splitbelow = true
  vim.opt.splitkeep = 'cursor'
  vim.opt.splitright = true
end

function M.indent()
  vim.opt.autoindent = true
  vim.opt.expandtab = true
  vim.opt.shiftwidth = 2
  vim.opt.smartindent = true
  vim.opt.tabstop = 2
end

function M.search()
  vim.opt.hlsearch = true
  vim.opt.ignorecase = true
  vim.opt.inccommand = 'split'
  vim.opt.smartcase = true
end

function M.behavior()
  vim.opt.mouse = ''
  vim.opt.list = false
  vim.opt.spelllang = { 'en' }
  vim.opt.timeoutlen = vim.g.vscode and 1000 or 300
end

function M.shell()
  vim.opt.shell = vim.env.SHELL or 'zsh'
  vim.opt.clipboard = vim.env.SSH_TTY and '' or 'unnamedplus'
  vim.opt.completeopt = 'menu,menuone,noselect'
end

function M.misc()
  vim.opt.formatoptions:append 'r'
  vim.opt.path:append '**'
  vim.opt.wildignore:append '*/node_modules/*'
  vim.opt.wildmode = 'longest:full,full'
  vim.opt.backspace = { 'start', 'eol', 'indent' }
  vim.opt.backup = false
  vim.opt.swapfile = false
  vim.opt.shortmess:append 'WICc'
  vim.g.deprecation_warnings = true

  -- Netrw
  vim.g.netrw_liststyle = 3

  -- Disable unused language providers to clean up :checkhealth
  vim.g.loaded_ruby_provider = 0
  vim.g.loaded_node_provider = 0
  vim.g.loaded_perl_provider = 0
  vim.g.loaded_python3_provider = 0
end

function M.setup()
  M.leader()
  M.ui()
  M.splits()
  M.indent()
  M.search()
  M.behavior()
  M.shell()
  M.misc()
end

return M
