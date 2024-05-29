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
export USER_ZSH_COMPLETIONS="$USER_ZSH_DATA/completions.d"

# Tools
export ZSH_AUTOSUGGEST_MANUAL_REBIND=1
export ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

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

# set PATH so it includes user's private bin if it exists
if [[ -d "$HOME/.local/bin" ]] ; then
    export PATH="$HOME/.local/bin:$PATH"
fi

# forgit
if [[ ! -z "${FORGIT_INSTALL_DIR}" ]]; then
  export PATH="$PATH:$FORGIT_INSTALL_DIR/bin"
fi

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
