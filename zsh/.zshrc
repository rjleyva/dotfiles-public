# Load the instant prompt if it exists
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Load the Powerlevel10k theme
source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

# Load zsh autosuggestions
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Load zsh syntax highlighting
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Git commands Alias
alias g="git"
alias gst="git status"
alias ga="git add"
alias gaa="git add ."
alias gra="git remote add"
alias gca="git commit --amend"
alias gl="git log"
alias gd="git diff"
alias gb="git branch"
alias gp="git push"
alias gmv="git mv -f"

# Alias "lg" to open LazyGit
alias lg="lazygit"

# Alias "nv" to lauch neovim
alias vim="nvim"

# Alias "ls" to use eza with icons and simplified output
alias ls="eza -al --color=always --long --git --icons=always --created --time-style=long-iso"

# Initialize Zoxide for smarter directory navigation
eval "$(zoxide init zsh)"

# Set the default theme for bat syntax highlighting
export BAT_THEME="gruvbox-dark"

# Customize FZF options for file and directory preview
export FZF_CTRL_T_OPTS="--preview 'eza --tree --color=always {} | head -200'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Custom FZF completion runner with different previews based on command
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo ${}'" "$@" ;;
    ssh)          fzf --preview 'dig {}' "$@" ;;
    *)            fzf --preview "eza --tree --color=always {} | head -200" "$@" ;;
  esac
}

# Set the default FZF commands for finding files and directories
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# FZF path completion function
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# FZF directory completion function
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

# Enable FZF integration with Zsh
eval "$(fzf --zsh)"

# Load Powerlevel10k configuration if it exists
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Load NVM (Node Version Manager)
export NVM_DIR="$HOME/.nvm"
[ -s "$(brew --prefix nvm)/nvm.sh" ] && \. "$(brew --prefix nvm)/nvm.sh"
[ -s "$(brew --prefix nvm)/bash_completion" ] && \. "$(brew --prefix nvm)/bash_completion"

export EDITOR=nvim

