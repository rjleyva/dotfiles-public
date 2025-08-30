# RJ dotfiles-public – Step by Step Guide 🌴

This guide will take you through installing my public-dotfiles on macOS in a clear, step by step manner, with each
command accompanied by an explanation so that you understand what it does and how to use it.

If you prefer a quicker approach, you may want to see the
[Quick Installation Guide](./quick-installation.md)

## Contents

1. [Install Homebrew](#install-homebrew) – the package manager for macOS
2. [Install GNU Stow](#install-gnu-stow) – a tool for managing dotfiles through symbolic links
3. [Install Node.js](#install-nodejs) – runtime required for npm-based development tools
   - [Install Global npm Packages](#install-global-npm-packages)
   - [Install Homebrew Packages](#install-homebrew-packages)

## Install Homebrew

[Homebrew](https://brew.sh/) is a package manager for macOS. In simple terms, it allows you to install, update, and
manage software easily. Rather than downloading tools individually from different websites, Homebrew lets you manage most
developer tools with a single command, keeping your setup organised and saving time.

Open your terminal and run the following command to install Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Once the installation has finished, your shell needs to know where to find the brew command.

On Apple Silicon Macs add the following line to your shell profile, then reload it

```bash
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
source ~/.zprofile
```

On Intel Macs Homebrew installs to /usr/local and usually works without extra steps.

To check if the installation was successful, run

```bash
brew --version
```

If you see an output like this, it means the software has been installed successfully on your machine.

```bash
NVIM v0.11.3
Build type: Release
LuaJIT 2.1.1753364724
Run "nvim -V1 -v" for more info
```

## Install [GNU Stow](https://www.gnu.org/software/stow/)

[GNU Stow](https://www.gnu.org/software/stow/) is a small yet very handy tool for managing dotfiles. Dotfiles are the
hidden configuration files that define how your applications and shell behave. By default these files sit directly in
your home directory, which can quickly become cluttered.

Stow tidies this up by using symbolic links (shortcuts). You keep all of your dotfiles together in one folder such as
`~/dotfiles-public`, and Stow creates links to them in the correct places within your home directory. This keeps your
setup organised, easier to back up, and much simpler to share or recreate on another machine.

Install GNU Stow with Homebrew

```bash
brew install stow
```

Check that the installation worked by running

```bash
stow --version
```

If this shows a version number, then Stow is ready to use.

## Clone this repository

Your dotfiles live in a GitHub repository so you can keep them version-controlled and easily reuse them across different
machines. Before cloning, it is best to move to your home directory so that Stow can place the symbolic links in the
correct locations. On macOS, your home is usually /Users/yourname. Running `cd` with no arguments takes you
straight there.

First, return to your home directory

```bash
cd
```

Now clone the repository:

```bash
git clone https://github.com/rjleyva/dotfiles-public.git ~/dotfiles-public
cd ~/dotfiles-public
```

Once you are inside the repository, you can tell Stow which configurations you would like to enable. For example, to
enable only Zsh, Git, and Neovim configs, run

```bash
# Example: only enable Zsh, Git, and Neovim configs
stow zsh git nvim
```

This will create symbolic links such as

- zsh/.zshrc → ~/.zshrc
- git/.gitconfig → ~/.gitconfig
- nvim/.config/nvim/ → ~/.config/nvim/

If you want to enable everything in the repository, run

```bash
# Symlink everything in the repository
stow .
```

And if you ever want to remove all the symbolic links created by this repository (safe to do, as it does not delete your
actual configuration files), run

```bash
# Remove all symlinks created by this repo (safe, does not delete configs)
stow -D .
```

## Install [Node.js](https://nodejs.org/en/)

Node.js is the JavaScript runtime that allows many developer tools to run outside of the browser. It is needed here
because a number of useful tools rely on it, including language servers, code formatters, and commit helpers. Without
Node.js, many of these tools simply would not work.

There are multiple ways to install Node.js (like `nvm` or `asdf`), but to keep things simple for newcomers we’ll use
**Homebrew**. This is the easiest way to get Node.js up and running on macOS without extra configuration.

Install Node.js with Homebrew

```bash
brew install node
```

Check that it has installed correctly by running

```bash
node --version
npm --version
```

If both commands print a version number, `Node.js` and `npm` are ready to use.

Now that `Node.js` is installed, the next step is to install some global npm packages. These packages provide essential
development tools that work across your whole system, not just in one project.

Most of them are

- Language servers which power features such as autocomplete, diagnostics, and linting in Neovim
- Formatters which automatically keep your code neat and consistent
- Workflow helpers such as commit tools and package managers

We install them globally because they are system-wide tools you will use in many different projects.

## Install Global npm Packages

To install them all in one go, copy and paste the command below

```bash
npm install -g \
 @olrtg/emmet-language-server \
 @vtsls/language-server \
 commitizen \
 corepack \
 eslint_d \
 graphql-language-service-cli \
 prettier \
 pyright \
 vscode-langservers-extracted \
 yaml-language-server
```

After installation, you can confirm that a package is available by checking its version, for example

```bash
prettier --version
```

If this prints a version number, then the global packages are installed correctly.

### What each package does

- `@olrtg/emmet-language-server` – Brings Emmet shorthand support (quick HTML and CSS expansions) into your editor
- `@vtsls/language-server` – Language server for TypeScript and JavaScript projects, with fast IntelliSense support
- `commitizen` – Helps you write structured Git commit messages that follow best practices
- `corepack` – Manages Node.js package managers (like Yarn and pnpm), making them easier to use system-wide
- `eslint_d` – A fast daemonised version of ESLint for linting JavaScript and TypeScript code
- `graphql-language-service-cli` – Language server for GraphQL, adding autocomplete and validation for queries
- `prettier` – Opinionated code formatter that keeps your code clean and consistent
- `pyright` – Fast type checker and language server for Python
- `vscode-langservers-extracted` – Provides language servers extracted from VS Code for HTML, CSS, and JSON
- `yaml-language-server` – Language server for YAML files, with validation and schema support

## Install Homebrew Packages

Not every tool can be installed through npm. Some, such as lua-language-server and marksman, are only available through
Homebrew. Alongside these, there are a number of other development tools, formatters, and utilities that make your
terminal experience more powerful and pleasant to use.

Run the command below to install everything in one go

```bash
brew install \
  bat \
  black \
  eza \
  fd \
  fzf \
  git \
  go \
  isort \
  lazygit \
  lua-language-server \
  marksman \
  neovim \
  pipx \
  powerlevel10k \
  python \
  stow \
  stylua \
  tmux \
  tlrc \
  tree \
  yq \
  zoxide \
  zsh-autosuggestions \
  zsh-syntax-highlighting
```

You can check that a package has installed by running it with the --version flag. For example

```bash
nvim --version
```

If this shows output such as NVIM v0.11.3, then Neovim is installed correctly and ready to use.

This step ensures your system has a solid foundation of language servers, formatters, and essential developer tools,
everything you’ll need for a productive Neovim setup.

### What each package does

- `bat` – A modern alternative to cat with syntax highlighting
- `black` – Python code formatter that enforces consistent style
- `eza` – A colourful and modern replacement for ls
- `fd` – A fast, user-friendly alternative to find
- `fzf` – Fuzzy finder for quickly searching files, history, and more
- `git` – Essential version control system
- `go` – Programming language often used for tools and servers
- `isort` – Python utility to automatically sort imports
- `lazygit` – A simple terminal interface for Git
- `lua-language-server` – Language server for Lua, required for Neovim configs
- `marksman` – Language server for Markdown files
- `neovim` – The editor itself, a modern fork of Vim
- `pipx` – Tool to install and run Python applications in isolated environments
- `powerlevel10k` – A fast, customisable theme for Zsh
- `python` – The Python programming language
- `stow` – Symlink manager for dotfiles (already covered above, but installed here too)
- `stylua` – Lua code formatter
- `tmux` – Terminal multiplexer, allows you to split and manage sessions
- `tlrc` – Tool to search and browse TLDR pages (community-driven simplified man pages)
- `tree` – Displays directory structures as a tree
- `yq` – Command-line YAML processor, similar to jq but for YAML
- `zoxide` – Smarter, faster way to jump between directories
- `zsh-autosuggestions` – Suggests commands as you type in Zsh
- `zsh-syntax-highlighting` – Highlights syntax in the Zsh shell for clarity

## Bat Configuration

[`bat`](https://github.com/sharkdp/bat) is an improved version of the classic cat command. It displays file contents
with syntax highlighting, line numbers, and even integrates with Git to show changes. This makes reading code and
configuration files in the terminal much easier.

After installing `bat`, you need to rebuild its syntax and theme cache. This step ensures that syntax highlighting and
themes work correctly on your machine.

Rebuild the cache with

```bash
bat cache --build
```

If the command succeeds, you should see output similar to this

```bash
No syntaxes were found in '/Users/yourname/.config/bat/syntaxes', using the default set.
Writing theme set to /Users/rjleyva/.cache/bat/themes.bin ... okay
Writing syntax set to /Users/rjleyva/.cache/bat/syntaxes.bin ... okay
Writing metadata to folder /Users/rjleyva/.cache/bat ... okay
```

This confirms that the cache was built successfully.

In this setup, the vague.tmTheme theme is already configured in your .zshrc, so you do not need to set it up manually

**A couple of extra things to keep in mind:**

- If you delete your `~/.cache directory`, you will need to run `bat cache --build` again to rebuild the syntax and
  theme cache.
- If you forget, you may see a warning such as

```bash
[bat warning]: Unknown theme 'vague', using default.
```

This will not break your setup. Simply run `bat cache --build` once more and the warning will disappear.

### Try It Out

To see bat in action, try running

```bash
bat ~/dotfiles-public/.wezterm.lua
```

You should see the contents of the file displayed with syntax highlighting, line numbers, and a clean layout.

## TMUX Configuration

Tmux will not work as expected straight away. It requires a couple of additional steps to ensure everything
functions properly.

The first step is to install the **TMUX Plugin Manager (TPM)**:

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

Next, open a tmux session by running:

```bash
tmux
```

Once inside the session, you need to source the configuration file. To do this, press:

```bash
# Hold Control and press a, then press :
<C-a> :
```

This opens a small command prompt at the bottom of the tmux window. Type the following and press Enter:

```bash
source-file ~/dotfiles-public/.config/tmux/tmux.conf
```

After sourcing, you can install all the plugins. Still inside tmux, press:

```bash
# Hold Control and press a, then press capital I
<C-a> I
```

If everything works correctly, you should see a message like this:

```bash
TMUX environment reloaded.

Done, press ENTER to continue.
```

This confirms the plugins have been installed successfully.

### TPM Plugins Used

```tmux
set -g @plugin "tmux-plugins/tpm"
set -g @plugin "tmux-plugins/tmux-sensible"
set -g @plugin "christoomey/vim-tmux-navigator"
set -g @plugin "joshmedeski/tmux-nerd-font-window-name"
set -g @plugin 'tmux-plugins/tmux-sensible'
set -g @plugin 'tmux-plugins/tmux-prefix-highlight'
```

### TMUX Keymaps

TMUX configuration includes several customised keymaps to make navigation and management more efficient.

```tmux
# Prefix remap
set -g prefix C-a
unbind C-b
bind-key C-a send-prefix
```

By default, tmux uses `Ctrl-b` as its prefix (the “activation key” before running any tmux command). Here it is remapped
to `Ctrl-a` for convenience. Think of it as the leader key, you always press `Ctrl-a` first, followed by another key to
trigger a command.

```tmux
# Splits
unbind %
bind | split-window -h
unbind '"'
bind - split-window -v
```

- `Ctrl-a |` splits the window vertically (side by side).
- `Ctrl-a -` splits the window horizontally (top and bottom).

```tmux
# Reload config
unbind r
bind r source-file ~/.config/tmux/tmux.conf \; display-message "Config reloaded"
```

- `Ctrl-a r` reloads your tmux configuration without restarting tmux.
- A small message appears to confirm the reload.

```tmux
# Pane resizing
bind -r j resize-pane -D 5
bind -r k resize-pane -U 5
bind -r h resize-pane -L 5
bind -r l resize-pane -R 5
bind -r m resize-pane -Z
```

- `Ctrl-a j` moves the border down.
- `Ctrl-a k` moves the border up.
- `Ctrl-a h` moves the border left.
- `Ctrl-a l` moves the border right.
- `Ctrl-a m` toggles zoom mode (focus on one pane, then back to all).

These use Vim style navigation keys (h, j, k, l).

```tmux
# Copy mode
set-window-option -g mode-keys vi
bind-key -T copy-mode-vi v send -X begin-selection
bind-key -T copy-mode-vi y send -X copy-selection
```

- Copy mode is now Vim-like.
- Inside copy mode:
- Press `v` to start a selection.
- Press `y` to copy the selection.
- This makes selecting and copying text feel just like Vim.

## A Note on Installing Everything

You can choose to skip or exclude certain tools if you know you will not need them. However, for these dotfiles to work
straight away, it is best to install everything listed.

That said, as a newcomer, I strongly recommend taking a little time to research each tool before removing or changing it.
Understanding what each tool does will save you trouble later on. I learnt this lesson the hard way when I accidentally
broke my own configuration a few months ago.

## Need Help?

I am happy to help fellow newcomers when I have the time. If you run into problems or have suggestions such as adding
plugins, you can

- Open a **discussion** on GitHub
- Or submit a **pull request**

I may not always be able to reply immediately because I work full time as a consultant, but I will get back to you as
soon as I can. This project is designed with newcomers in mind and your feedback is always appreciated.

## Next Steps

Once you have finished the setup you are ready to dive into the editor itself.
To understand how everything fits together including plugins, workflow, demonstrations and day to day usage, take a look
at the detailed guide here [Editor Workflow](../docs/editor-workflow.md)
