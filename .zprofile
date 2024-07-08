# Create zsh data dir if missing
if [[ ! -d $USER_ZSH_SITE_FUNCTIONS ]]; then
  mkdir -p $USER_ZSH_SITE_FUNCTIONS
fi

# Download proto manager if missing.
if [[ ! -e ${HOME}/.proto ]]; then
  curl -fsSL https://moonrepo.dev/install/proto.sh | bash
fi

# Download zimfw plugin manager if missing.
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
      https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
fi

# Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  source ${ZIM_HOME}/zimfw.zsh init -q
fi

# If you're using Homebrew, you'll want this enabled
if [[ -f "/opt/homebrew/bin/brew" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# If you're using Linuxbrew, you'll want this enabled
if [[ -f "/home/linuxbrew/.linuxbrew/bin/brew" ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

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
if [[ -d "$HOME/.go/bin" ]] ; then
    export PATH="$GOBIN:$PATH"
fi

# Proto
export PATH="$PROTO_HOME/shims:$PROTO_HOME/bin:$PATH"
