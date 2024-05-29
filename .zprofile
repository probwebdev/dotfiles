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

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':fzf-tab:*' switch-group '<' '>'
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza --tree --level=2 --color=always --git $realpath | head -200'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza --tree --level=2 --color=always --git $realpath | head -200'
zstyle ':fzf-tab:complete:nvim:*' fzf-preview 'fzf-preview-all $realpath'

# Download zimfw plugin manager if missing.
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
      https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
fi

# Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  source ${ZIM_HOME}/zimfw.zsh init -q
fi

source ${ZIM_HOME}/init.zsh

#
# zsh-history-substring-search
#

zmodload -F zsh/terminfo +p:terminfo
# Bind ^[[A/^[[B manually so up/down works both before and after zle-line-init
for key ('^[[A' '^P' ${terminfo[kcuu1]}) bindkey ${key} history-substring-search-up
for key ('^[[B' '^N' ${terminfo[kcud1]}) bindkey ${key} history-substring-search-down
for key ('k') bindkey -M vicmd ${key} history-substring-search-up
for key ('j') bindkey -M vicmd ${key} history-substring-search-down
unset key

# Create zsh data dir if missing
if [[ ! -d $USER_ZSH_COMPLETIONS ]]; then
  mkdir -p $USER_ZSH_COMPLETIONS
fi

[[ -s "$USER_ZSH_DATA/fzf-preview.zsh" ]] && source $USER_ZSH_DATA/fzf-preview.zsh

# pnpm completions
[[ -s "$USER_ZSH_COMPLETIONS/_pnpm" ]] && source "$USER_ZSH_COMPLETIONS/_pnpm"

# bun completions
[[ -s "$USER_ZSH_COMPLETIONS/_bun" ]] && source "$USER_ZSH_COMPLETIONS/_bun"

# proto completions
[[ -s "$USER_ZSH_COMPLETIONS/_proto" ]] && source "$USER_ZSH_COMPLETIONS/_proto"
