# Create zsh data dir if missing
if [[ ! -d $USER_ZSH_SITE_FUNCTIONS ]]; then
  mkdir -p $USER_ZSH_SITE_FUNCTIONS
fi

# set PATH so it includes user's private bin
if [[ ! -d "$USER_BIN_HOME" ]] ; then
    mkdir -p $USER_BIN_HOME
fi
export PATH="$USER_BIN_HOME:$PATH"

# Add proto bins and shims to PATH
export PATH="$PROTO_HOME/shims:$PROTO_HOME/bin:$PATH"

# Added by Toolbox App
export PATH="$PATH:$HOME/.local/share/JetBrains/Toolbox/scripts"

# Download proto manager if missing.
if [[ ! -d ${HOME}/.proto ]]; then
  curl -fsSL https://moonrepo.dev/install/proto.sh | bash
  ${HOME}/.proto/bin/proto completions >| ${USER_ZSH_SITE_FUNCTIONS}/_proto
fi

# Download tmux plugin manager if missing.
if [[ ! -d ${HOME}/.tmux/plugins ]]; then
  mkdir -p ${HOME}/.tmux/plugins
  git clone https://github.com/tmux-plugins/tpm ${HOME}/.tmux/plugins/tpm
fi

# Download vim/nvim plugin manager if missing.
if [[ ! -e ${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vim ]]; then
  curl -fLo ${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
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
