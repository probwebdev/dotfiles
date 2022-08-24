source $HOME/.zshenv
source $HOME/.zprofile

export DEFAULT_USER=$(whoami)

# Launch Starship
eval "$(starship init zsh)"

