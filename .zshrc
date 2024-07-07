source $HOME/.zshenv
source $HOME/.zprofile
source $HOME/.zaliases

# Initialize Starship
eval "$(starship init zsh)"

# Initialize FZF (requires >=fzf@0.48.0)
source <(fzf --zsh)

# Initialize zoxide
eval "$(zoxide init zsh)"

# Activate proto (requires >=proto@0.38.0)
eval "$(proto activate zsh)"
