source $HOME/.zshenv
source $HOME/.zprofile
source $HOME/.zaliases

# Launch Starship
eval "$(starship init zsh)"

# Launch FZF (requires >=0.48.0)
eval "$(fzf --zsh)"

# Launch zoxide
eval "$(zoxide init zsh)"
