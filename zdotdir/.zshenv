skip_global_compinit=1

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# enable firefox wayland when available
if [[ "${XDG_SESSION_TYPE}" == "wayland" ]] ; then
    export MOZ_ENABLE_WAYLAND=1
fi

# Brew
export HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew";
export HOMEBREW_CELLAR="$HOMEBREW_PREFIX/Cellar";
export HOMEBREW_REPOSITORY="$HOMEBREW_PREFIX/Homebrew";
export PATH="$HOMEBREW_PREFIX/bin:$HOMEBREW_PREFIX/sbin${PATH+:$PATH}";
export MANPATH="$HOMEBREW_PREFIX/share/man${MANPATH+:$MANPATH}:";
export INFOPATH="$HOMEBREW_PREFIX/share/info:${INFOPATH:-}";
export FPATH="$HOMEBREW_PREFIX/share/zsh/site-functions:${FPATH}"
export HOMEBREW_NO_CLEANUP_FORMULAE=starship

# User configuration
export WORDCHARS=${WORDCHARS//[\/]}
export TERM="xterm-256color"
export DOCKER_CONTENT_TRUST=0
export EDITOR="$HOMEBREW_PREFIX/bin/nvim"
export VISUAL="$HOMEBREW_PREFIX/bin/nvim"
export DEFAULT_USER=$(whoami)

# Volta
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# ZIM
export ZIM_HOME=${ZDOTDIR:-$HOME}/.zim

# Added by Toolbox App
export PATH="$PATH:$HOME/.local/share/JetBrains/Toolbox/scripts"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
