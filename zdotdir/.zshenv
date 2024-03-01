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

# ZIM
export ZIM_HOME=${ZDOTDIR:-$HOME}/.zim

# Added by Toolbox App
export PATH="$PATH:$HOME/.local/share/JetBrains/Toolbox/scripts"

# rust
source "$HOME/.cargo/env"

# go
export GOBIN="$HOME/go/bin"
export PATH="$GOBIN:$PATH"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# proto
export PROTO_HOME="$HOME/.proto"
export PATH="$PROTO_HOME/shims:$PROTO_HOME/bin:$PATH"
