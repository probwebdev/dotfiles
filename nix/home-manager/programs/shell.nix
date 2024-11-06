{ ... }:
{
  programs.zsh.enable = true;
  programs.zsh.enableCompletion = false;

  programs.zsh.history = {
    ignoreAllDups = true;
    ignoreDups = true;
    append = true;
  };

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

  programs.zsh.shellAliases = {
    "list" = "eza -l -o -a --git --level=1 --header";

    # TPM aliases
    "tpmi" = "~/.tmux/plugins/tpm/bin/install_plugins";
    "tpmup" = "~/.tmux/plugins/tpm/bin/update_plugins all";
    "tpmclean" = "~/.tmux/plugins/tpm/bin/clean_plugins";

    # Nvim aliases
    "plugi" = "nvim -es -u ~/.config/nvim/init.vim -i NONE -c 'PlugInstall' -c 'qa'";
    "plugup" = "nvim -es -u ~/.config/nvim/init.vim -i NONE -c 'PlugUpdate' -c 'qa'";

    # Custom aliases
    "toolsup" = "echo $'Proto upgrade' ; proto upgrade ; echo $'\nZIM update' ; zimfw update ; echo $'\nNvim PlugUpdate' ; plugup ; echo $'\nTPM plugins update' ; tpmup";
  };

  programs.zsh.initExtraFirst = ''
    skip_global_compinit=1
    zmodload -F zsh/terminfo +p:terminfo
  '';
  programs.zsh.initExtra = ''
    HISTDUP=erase
    setopt hist_save_no_dups
    setopt hist_find_no_dups
    setopt no_nomatch

    # Set editor default keymap to emacs (`-e`) or vi (`-v`)
    bindkey -v
    bindkey '^p' history-search-backward
    bindkey '^n' history-search-forward
    bindkey '^[w' kill-region

    # Bind ^[[A/^[[B manually so up/down works both before and after zle-line-init
    for key ('^[[A' '^P' $terminfo[kcuu1]) bindkey $key history-substring-search-up
    for key ('^[[B' '^N' $terminfo[kcud1]) bindkey $key history-substring-search-down
    for key ('k') bindkey -M vicmd $key history-substring-search-up
    for key ('j') bindkey -M vicmd $key history-substring-search-down
    unset key

    # Private zsh configuration
    [[ -s "$HOME/.zshrc-private" ]] && source "$HOME/.zshrc-private"

    # Completion styling and fzf preview
    [[ -s "$USER_ZSH_DATA/zstyle.zsh" ]] && source $USER_ZSH_DATA/zstyle.zsh
    [[ -s "$USER_ZSH_DATA/fzf-preview.zsh" ]] && source $USER_ZSH_DATA/fzf-preview.zsh

    # Initialize ZIM
    source $ZIM_HOME/init.zsh

    # Activate proto (requires >=proto@0.38.0)
    eval "$(proto activate zsh --no-bin --no-shim)"
  '';

  programs.fzf.enable = true;
  programs.zoxide.enable = true;
  programs.starship = {
    enable = true;
  };
}
