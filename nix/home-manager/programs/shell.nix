{...}: {
  programs.fzf.enable = true;
  programs.zoxide.enable = true;
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

  programs.zsh.sessionVariables = {
    USER_BIN_HOME = "$HOME/.local/bin";
    USER_ZSH_DATA = "$HOME/.local/share/zsh";
    USER_ZSH_SITE_FUNCTIONS = "$USER_ZSH_DATA/site-functions";
    ZIM_HOME = "$HOME/.zim";
    PROTO_HOME = "$HOME/.proto";
    GOROOT = "$HOME/.go";
    GOBIN = "$HOME/.go/bin";
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
  programs.zsh.profileExtra = ''
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
    if [[ ! -d $HOME/.proto ]]; then
      curl -fsSL https://moonrepo.dev/install/proto.sh | bash
      $HOME/.proto/bin/proto completions >| $USER_ZSH_SITE_FUNCTIONS/_proto
    fi

    # Download tmux plugin manager if missing.
    if [[ ! -d $HOME/.tmux/plugins ]]; then
      mkdir -p $HOME/.tmux/plugins
      git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
    fi

    # Download vim/nvim plugin manager if missing.
    if [[ ! -e $HOME/.local/share/nvim/site/autoload/plug.vim ]]; then
      curl -fLo $HOME/.local/share/nvim/site/autoload/plug.vim --create-dirs \
          https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    fi

    # Download zimfw plugin manager if missing.
    if [[ ! -e $ZIM_HOME/zimfw.zsh ]]; then
      curl -fsSL --create-dirs -o $ZIM_HOME/zimfw.zsh \
          https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
    fi

    # Install missing modules, and update $ZIM_HOME/init.zsh if missing or outdated.
    if [[ ! $ZIM_HOME/init.zsh -nt $HOME/.zimrc ]]; then
      source $ZIM_HOME/zimfw.zsh init -q
    fi
  '';
}
