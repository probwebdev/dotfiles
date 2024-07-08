skip_global_compinit=1
zmodload -F zsh/terminfo +p:terminfo

# User configuration
export WORDCHARS=${WORDCHARS//[\/]}
export TERM="xterm-256color"
export EDITOR="nvim"
export VISUAL="nvim"
export DEFAULT_USER=$(whoami)
export GPG_TTY=$(tty)
export LANG=en_US.UTF-8

# Private env
[[ -s "$HOME/.zshenv-custom" ]] && source "$HOME/.zshenv-custom"

# Tools
export LESSOPEN='|fzf-preview-all %s'
export ZSH_AUTOSUGGEST_MANUAL_REBIND=1
export ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="--height=85% --tmux=85% --preview-window='right:60%:wrap,<50(up:55%:wrap)'"
export FZF_COMPLETION_TRIGGER='~~'
export HOMEBREW_NO_CLEANUP_FORMULAE=starship

# History
HISTSIZE=5000
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Keybindings
# Set editor default keymap to emacs (`-e`) or vi (`-v`)
bindkey -v
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

#
# zsh-history-substring-search
#

# Bind ^[[A/^[[B manually so up/down works both before and after zle-line-init
for key ('^[[A' '^P' ${terminfo[kcuu1]}) bindkey ${key} history-substring-search-up
for key ('^[[B' '^N' ${terminfo[kcud1]}) bindkey ${key} history-substring-search-down
for key ('k') bindkey -M vicmd ${key} history-substring-search-up
for key ('j') bindkey -M vicmd ${key} history-substring-search-down
unset key

# Completion styling
[[ -s "$USER_ZSH_DATA/zstyle.zsh" ]] && source $USER_ZSH_DATA/zstyle.zsh
# FZF preview
[[ -s "$USER_ZSH_DATA/fzf-preview.zsh" ]] && source $USER_ZSH_DATA/fzf-preview.zsh

# Aliases
source $HOME/.zaliases

# Initialize ZIM
source ${ZIM_HOME}/init.zsh

# Activate proto (requires >=proto@0.38.0)
eval "$(proto activate zsh)"

# Initialize FZF (requires >=fzf@0.48.0)
source <(fzf --zsh)

# Initialize Starship
eval "$(starship init zsh)"

# Initialize zoxide
eval "$(zoxide init zsh)"
