{lib, ...}: {
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
  };

  programs.zsh.shellAliases = {
    "list" = "eza -l -o -a --git --level=1 --header";

    # TPM aliases
    "tpmi" = "~/.tmux/plugins/tpm/bin/install_plugins";
    "tpmup" = "~/.tmux/plugins/tpm/bin/update_plugins all";
    "tpmclean" = "~/.tmux/plugins/tpm/bin/clean_plugins";
  };

  programs.zsh.initContent = lib.mkMerge [
    (lib.mkOrder 500 ''
      skip_global_compinit=1
      zmodload -F zsh/terminfo +p:terminfo
    '')
    (lib.mkOrder 1000 ''
      HISTDUP=erase
      setopt hist_save_no_dups
      setopt hist_find_no_dups
      setopt no_nomatch

      # Set editor default keymap to emacs (`-e`) or vi (`-v`)
      bindkey -v
      bindkey '^p' history-search-backward
      bindkey '^n' history-search-forward
      bindkey '^[w' kill-region

      # Private zsh configuration
      [[ -s "$HOME/.zshrc-private" ]] && source "$HOME/.zshrc-private"

      # Completion styling and fzf preview
      [[ -s "$USER_ZSH_DATA/zstyle.zsh" ]] && source $USER_ZSH_DATA/zstyle.zsh
      [[ -s "$USER_ZSH_DATA/fzf-preview.zsh" ]] && source $USER_ZSH_DATA/fzf-preview.zsh

      # Initialize ZIM
      if [[ -s "$ZIM_HOME/init.zsh" ]]; then
        source "$ZIM_HOME/init.zsh"
      else
        autoload -Uz compinit
        compinit
      fi

      if (( $+widgets[history-substring-search-up] )); then
        for key ('^[[A' '^P' $terminfo[kcuu1]) bindkey $key history-substring-search-up
        for key ('^[[B' '^N' $terminfo[kcud1]) bindkey $key history-substring-search-down
        bindkey -M vicmd k history-substring-search-up
        bindkey -M vicmd j history-substring-search-down
        unset key
      fi

      # Enable Determinate NIX autocomplete
      (( $+commands[determinate-nixd] )) && eval "$(determinate-nixd completion zsh)"

      # Run explicitly after activation; opening a shell never installs tools.
      dotfiles-setup() (
        set -e
        set -o pipefail
        mkdir -p "$USER_ZSH_SITE_FUNCTIONS" "$HOME/.tmux/plugins" "$ZIM_HOME"
        if [[ ! -f "$HOME/.tmux/plugins/tpm/tpm" ]]; then
          git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
        fi
        if [[ ! -s "$ZIM_HOME/zimfw.zsh" ]]; then
          local installer
          installer=$(mktemp)
          trap 'rm -f -- "$installer"' EXIT
          curl -fsSL https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh -o "$installer"
          mv "$installer" "$ZIM_HOME/zimfw.zsh"
        fi
        source "$ZIM_HOME/zimfw.zsh" install
        source "$ZIM_HOME/zimfw.zsh" init -q
        if (( $+functions[dotfiles-setup-dev] )); then
          dotfiles-setup-dev
        fi
      )

      toolsup() {
        if (( $+commands[proto] )) && [[ -n "$PROTO_HOME" ]]; then
          proto upgrade || return
        fi
        if [[ -s "$ZIM_HOME/zimfw.zsh" ]]; then
          source "$ZIM_HOME/zimfw.zsh" update || return
        fi
        if [[ -x "$HOME/.tmux/plugins/tpm/bin/update_plugins" ]]; then
          "$HOME/.tmux/plugins/tpm/bin/update_plugins" all
        fi
      }
    '')
  ];
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

    # JetBrains Toolbox App
    if [[ "$OSTYPE" == "darwin"* && -d "$HOME/Library/Application Support/JetBrains/Toolbox/scripts" ]]; then
      export PATH="$PATH:$HOME/Library/Application Support/JetBrains/Toolbox/scripts"
    else
      export PATH="$PATH:$HOME/.local/share/JetBrains/Toolbox/scripts"
    fi

    # OpenCode
    if [[ ! "$OSTYPE" == "darwin"* ]]; then
      export PATH="$HOME/.opencode/bin:$PATH"
    fi

  '';
}
