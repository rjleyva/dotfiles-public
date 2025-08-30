# RJ dotfiles-public – Quick Installation 🌴

## One-Liner Install

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" && \
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile && source ~/.zprofile && \
brew install stow node git neovim tmux lazygit lua-language-server marksman python pipx fd fzf bat black isort stylua yq zoxide zsh-autosuggestions zsh-syntax-highlighting powerlevel10k eza tlrc && \
npm install -g @olrtg/emmet-language-server @vtsls/language-server commitizen corepack eslint_d graphql-language-service-cli prettier pyright vscode-langservers-extracted yaml-language-server && \
git clone https://github.com/rjleyva/dotfiles-public.git ~/dotfiles-public && cd ~/dotfiles-public && stow .
```

This will:

- Install Homebrew (Apple Silicon ready) and add it to your path.
- Install core development tools such as Neovim, tmux, Lua and Marksman language servers, Python and formatters.
- Install global npm language servers.
- Clone this repository into ~/dotfiles-public and symlink configs with Stow.

## Usage

```bash
# Remove symlinks (safe, non-destructive)
stow -D .
```

```bash
# Symlink selectively
stow zsh git nvim
```

Defaults are opinionated but minimal. Adjust to your needs.

### Bat Configuration Reminder

After installing `bat` rebuild the syntax and theme cache

```bash
bat cache --build
```

## TMUX Configuration

Tmux requires a little extra setup to function as expected.

First, install the TMUX Plugin Manager (TPM):

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

Open a tmux session:

```bash
tmux
```

Then source your configuration and install the plugins:

```tmux
# Source config
<C-a> :
source-file ~/dotfiles-public/.config/tmux/tmux.conf

# Install plugins
<C-a> I
```

You should see a confirmation message once the plugins are installed successfully.

### TPM Plugins

```tmux
set -g @plugin "tmux-plugins/tpm"
set -g @plugin "tmux-plugins/tmux-sensible"
set -g @plugin "christoomey/vim-tmux-navigator"
set -g @plugin "joshmedeski/tmux-nerd-font-window-name"
set -g @plugin 'tmux-plugins/tmux-sensible'
set -g @plugin 'tmux-plugins/tmux-prefix-highlight'
```

### Keymaps

The configuration includes custom keymaps for a smoother workflow:

```tmux
# Prefix remap
set -g prefix C-a
unbind C-b
bind-key C-a send-prefix

# Splits
bind | split-window -h
bind - split-window -v

# Reload config
bind r source-file ~/.config/tmux/tmux.conf \; display-message "Config reloaded"

# Pane resizing
bind -r j resize-pane -D 5
bind -r k resize-pane -U 5
bind -r h resize-pane -L 5
bind -r l resize-pane -R 5
bind -r m resize-pane -Z

# Copy mode (Vim-like)
set-window-option -g mode-keys vi
bind-key -T copy-mode-vi v send -X begin-selection
bind-key -T copy-mode-vi y send -X copy-selection
```

- Prefix remapped to `Ctrl-a`
- Vim style splits and pane navigation
- Quick reload with `Ctrl-a r`
- Resize panes with Vim keys (h, j, k, l)
- Copy mode is Vim-like for consistency

## Troubleshooting

### Stow conflicts (existing dotfiles)

If you encounter the message existing target is not a symlink back up and remove the old configuration before
running Stow again

```bash
mv ~/.zshrc ~/.zshrc.backup
stow zsh
```

### Homebrew not found

Make sure your shell environment has been updated

```bash
eval "$(/opt/homebrew/bin/brew shellenv)"
```

### npm command not found

Confirm that Node has been installed with brew install node then restart your shell

### Rollback

To remove all symlinks, uninstall the packages, and delete this repository run

```bash
cd ~/dotfiles-public && stow -D . && cd ~ && \
brew uninstall --ignore-dependencies stow node git neovim tmux lazygit lua-language-server marksman python pipx fd fzf bat black isort stylua yq zoxide zsh-autosuggestions zsh-syntax-highlighting powerlevel10k eza tlrc && \
npm uninstall -g @olrtg/emmet-language-server @vtsls/language-server commitizen corepack eslint_d graphql-language-service-cli prettier pyright vscode-langservers-extracted yaml-language-server && \
rm -rf ~/dotfiles-public
```

That completes the process from zero to a full environment in under five minutes.
For further reference including demonstrations, see [Editor Worflow](../docs/editor-workflow.md).
