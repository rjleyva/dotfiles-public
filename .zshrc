# Editor & PATH
export EDITOR=nvim

# Pipx bin path
export PATH="$PATH:/Users/rjleyva/.local/bin"

# Vi Mode Configuration
bindkey -v
export KEYTIMEOUT=1

zle-keymap-select() {
  if [[ $KEYMAP == vicmd ]]; then
    echo -ne "\e]2;NORMAL MODE\a"
  else
    echo -ne "\e]2;INSERT MODE\a"
  fi
}
zle -N zle-keymap-select

# Theme & Prompt
source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

# Load Powerlevel10k configuration if it exists
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# Instant prompt if it exists
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Zsh Plugins
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Aliases
alias gg="lazygit"
alias ls="eza -al --color=always --long --git --icons=always --created --time-style=long-iso"
alias tree="eza --tree --all"

# Zoxide (Smart Directory Navigation)
eval "$(zoxide init zsh)"

# Bat Theme
export BAT_THEME="vague"

# FZF Configuration
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_OPTS="--preview '([[ -d {} ]] && eza --tree --color=always {} | head -200) || (bat --style=numbers --color=always {} | head -200)'"

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

_fzf_compgen_path() { fd --hidden --exclude .git . "$1"; }
_fzf_compgen_dir()  { fd --type=d --hidden --exclude .git . "$1"; }

eval "$(fzf --zsh)"
