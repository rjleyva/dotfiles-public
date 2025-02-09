# RJ Leyva's dotfiles 🚀

I've always believed that the tools we use shape not only our workflow but also our mindset and creativity. Inspired by Josean Martinez's Neovim setup, I began my own journey of crafting a personalized, efficient workspace.

I deeply respect Folke’s work and have spent a lot of time exploring his LazyVim distro. While it’s an incredible tool, I wanted a fresh start—something that I could shape from the ground up. That's why I transitioned to Josean’s personal configuration as a foundation, making gradual tweaks to match my evolving workflow. So far, I’ve removed the status line, simplified the dashboard, and embraced a more minimalistic approach to help me focus on what truly matters.

One of my favorite elements is the Solarized Osaka colorscheme by Takuya Matsuyama. Its perfectly balanced tones create an environment that is both calming and energizing—exactly what I need for deep focus.

## Why This Exists

This repository serves as:

- A personal reference for my evolving Neovim configuration.
- A way to document and refine my workflow over time.

## My Neovim Setup

### Core Utilities

- Neovim – Modern, extensible Vim alternative (Thiago de Arruda)
- Git – Version control system (Linus Torvalds)
- lazygit – Simple terminal UI for Git (jesseduffield)

### Search & Navigation

- ripgrep – Fast text searching (Andrew Gallant)
- fzf – Fuzzy finder (Junegunn Choi)
- fd – Simpler find alternative (David Peter)

### Terminal Enhancements

- Oh My Zsh – Zsh configuration framework (Robby Russell)
- eza – Modern ls replacement (Christina Sørensen)
- bat – Syntax-highlighted cat alternative (David Peter)
- delta – Git diff viewer (dandavison)
- tree – Directory structure visualization (Steve Baker)

### Terminal Workflow

- tmux – Terminal multiplexer created by (Nicholas Marriott)

### Aesthetics & Experience

- Solarized Osaka – My go-to colorscheme (Takuya Matsuyama)
- Nerd Font (PlemolJP) – Beautiful, functional fonts (tawara / yuru7)
- WezTerm – Terminal with true color and undercurl support (Wez Furlong)

## Neovim Configuration Breakdown

### Core Functionality

- nvim-lspconfig – Easy configuration for Neovim's built-in LSP.
- mason.nvim – Manages LSP servers, linters, and formatters.

### Productivity & Editing Enhancements

- nvim-cmp – Autocompletion framework for Neovim.
- nvim-autopairs – Automatically closes brackets and quotes.
- substitute.nvim – Enhances substitution commands for better text replacement.
- surround.nvim – Quick manipulation of surrounding characters (quotes, brackets, etc.).
- vim-maximizer – Maximizes and restores the current split window.
- which-key.nvim – Displays available keybindings in a popup.

### UI & Theming

- colorscheme.lua – Custom theme configuration (e.g., Solarized Osaka).
- nvim-tree.lua – A file explorer for better project navigation.
- trouble.nvim – Pretty diagnostics list to easily view LSP errors and warnings.
- todo-comments.nvim – Highlights and manages TODOs in your code.
- ui.lua – Custom UI tweaks (likely for better aesthetics and usability).

### Navigation & Searching

- telescope.nvim – Fuzzy finder for files, text, and more.
- nvim-treesitter – Better syntax highlighting and parsing.
- nvim-treesitter-text-objects – Enhances text object selection with Treesitter.

### Git & Version Control

- gitsigns.nvim – Git integration to show changes in the gutter.
- lazygit.nvim – Integrates lazygit for an interactive Git UI inside Neovim.

### Code Refactoring & Testing

- refactoring.nvim – Simplifies common refactoring operations.
- testing.lua – Likely for running tests (you might be using nvim-test or a custom setup).
- formatting.lua – Configures code formatting tools.

## Inspirations & Credits

- Josean Martinez’s
- Folke
- Takuya Matsuyama
- Thiago de Arruda
- Linus Torvalds
- Jesse Duffield
- Wez Furlong
- Robby Russell
- Andrew Gallant (BurntSushi)
- Junegunn Choi
- David Peter (sharkdp)
- Christina Sørensen (cafkafk)
- David Peter (sharkdp)
- Dan Davison
- Steve Baker
- tawara (yuru7)
- Nicholas Marriott
