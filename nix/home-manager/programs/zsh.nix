{ ... }:
{
  programs.zsh.enable = true;
  programs.zsh.enableCompletion = false;
  programs.zsh.history.ignoreAllDups = true;
  programs.zsh.history.ignoreDups = true;
  programs.zsh.history.append = true;
  programs.zsh.historySubstringSearch.enable = true;
  programs.zsh.localVariables = {
    TERM = "xterm-256color";
    SUDO_EDITOR = "$(which nvim)";
    EDITOR = "$(which nvim)";
    VISUAL = "$(which nvim)";
    DEFAULT_USER = "$(whoami)";
    GPG_TTY = "$(tty)";
    LANG = "en_US.UTF-8";
    LESSOPEN = "|fzf-preview-all %s";
    ZSH_AUTOSUGGEST_MANUAL_REBIND = "1";
    ZSH_HIGHLIGHT_HIGHLIGHTERS = "(main brackets)";
    FZF_DEFAULT_COMMAND = "fd --type f --strip-cwd-prefix --hidden --follow --exclude .git";
    FZF_CTRL_T_COMMAND = "$FZF_DEFAULT_COMMAND";
    FZF_DEFAULT_OPTS = "--height=85% --tmux=85% --preview-window='right:60%:wrap,<50(up:55%:wrap)'";
    FZF_COMPLETION_TRIGGER = "~~";
  };
  programs.zsh.initExtraFirst = ''
    skip_global_compinit=1
    zmodload -F zsh/terminfo +p:terminfo
  '';
  programs.zsh.initExtra = ''
    # Private zsh configuration
    [[ -s "$HOME/.zshrc-private" ]] && source "$HOME/.zshrc-private"
    # Completion styling and fzf preview
    [[ -s "$USER_ZSH_DATA/zstyle.zsh" ]] && source $USER_ZSH_DATA/zstyle.zsh
    [[ -s "$USER_ZSH_DATA/fzf-preview.zsh" ]] && source $USER_ZSH_DATA/fzf-preview.zsh

    # Aliases
    source $HOME/.zaliases

    # Initialize ZIM
    source $ZIM_HOME/init.zsh

    # Activate proto (requires >=proto@0.38.0)
    eval "$(proto activate zsh --no-bin --no-shim)"

    # Initialize FZF (requires >=fzf@0.48.0)
    source <(fzf --zsh)

    # Initialize Starship
    eval "$(starship init zsh)"

    # Initialize zoxide
    eval "$(zoxide init zsh)"
  '';
}
