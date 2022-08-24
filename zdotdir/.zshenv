skip_global_compinit=1

# Oh-My-ZSH configuration
#export DISABLE_MAGIC_FUNCTIONS=true
#export DISABLE_UNTRACKED_FILES_DIRTY=true
#export DISABLE_AUTO_UPDATE=true
#export DISABLE_UPDATE_PROMPT=true

# User configuration
export WORDCHARS=${WORDCHARS//[\/]}
export HOMEBREW_NO_CLEANUP_FORMULAE=starship
export TERM="xterm-256color"
export LC_ALL="en_GB.UTF-8"
export DOCKER_CONTENT_TRUST=0
export EDITOR="$HOMEBREW_PREFIX/opt/vim"
export VISUAL="$HOMEBREW_PREFIX/opt/vim"

# Volta
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# ZIM
export ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim
