skip_global_compinit=1

# set PATH so it includes user's private bin if it exists
if [[ -d "$HOME/.local/bin" ]] ; then
    export PATH="$HOME/.local/bin:$PATH"
fi

# User configuration
export WORDCHARS=${WORDCHARS//[\/]}
export TERM="xterm-256color"
export DOCKER_CONTENT_TRUST=0
export EDITOR="nvim"
export VISUAL="nvim"
export DEFAULT_USER=$(whoami)
export LANG=en_US.UTF-8
export GPG_TTY=$(tty)

# Tools
export ZSH_AUTOSUGGEST_MANUAL_REBIND=1
export ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Private env
[[ -s "$HOME/.zshenv-custom" ]] && source "$HOME/.zshenv-custom"

# ZIM
export ZIM_HOME=${ZDOTDIR:-$HOME}/.zim

# Added by Toolbox App
export PATH="$PATH:$HOME/.local/share/JetBrains/Toolbox/scripts"

# rust
[[ -s "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

# go
if [[ -d "$HOME/go/bin" ]] ; then
    export GOBIN="$HOME/go/bin"
    export PATH="$GOBIN:$PATH"
fi

# bun
if [[ -d "$HOME/.bun" ]] ; then
    export BUN_INSTALL="$HOME/.bun"
    export PATH="$BUN_INSTALL/bin:$PATH"
fi

# proto
export PROTO_HOME="$HOME/.proto"
export PATH="$PROTO_HOME/shims:$PROTO_HOME/bin:$PATH"
