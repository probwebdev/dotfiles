skip_global_compinit=1

# User configuration
export WORDCHARS=${WORDCHARS//[\/]}
export TERM="xterm-256color"
export DOCKER_CONTENT_TRUST=0
export EDITOR="nvim"
export VISUAL="nvim"
export DEFAULT_USER=$(whoami)
export LANG=en_US.UTF-8
export GPG_TTY=$(tty)
export USER_ZSH_DATA="${XDG_DATA_HOME:-$HOME/.local/share}/zsh"
export USER_ZSH_SITE_FUNCTIONS="$USER_ZSH_DATA/site-functions"

# Tools
export LESSOPEN='|fzf-preview-all %s'
export ZSH_AUTOSUGGEST_MANUAL_REBIND=1
export ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="--height=85% --tmux=85% --preview-window='right:60%:wrap,<50(up:55%:wrap)'"
export FZF_COMPLETION_TRIGGER='~~'

# If you're using Homebrew, you'll want this enabled
if [[ -f "/opt/homebrew/bin/brew" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
  export HOMEBREW_NO_CLEANUP_FORMULAE=starship
fi

# If you're using Linuxbrew, you'll want this enabled
if [[ -f "/home/linuxbrew/.linuxbrew/bin/brew" ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  export HOMEBREW_NO_CLEANUP_FORMULAE=starship
fi

# Private env
[[ -s "$HOME/.zshenv-custom" ]] && source "$HOME/.zshenv-custom"

# ZIM
export ZIM_HOME=${ZDOTDIR:-$HOME}/.zim

# set PATH so it includes user's private bin
if [[ ! -d "$HOME/.local/bin" ]] ; then
    mkdir -p $HOME/.local/bin
fi
export PATH="$HOME/.local/bin:$PATH"

# Added by Toolbox App
export PATH="$PATH:$HOME/.local/share/JetBrains/Toolbox/scripts"

# rust
[[ -s "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

# go
if [[ -d "$HOME/.go" ]] ; then
    export GOPATH="$HOME/.go"
    export GOBIN="$GOPATH/bin"
    export PATH="$GOBIN:$PATH"
fi

# proto
export PROTO_HOME="$HOME/.proto"
export PATH="$PROTO_HOME/shims:$PROTO_HOME/bin:$PATH"
