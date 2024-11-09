{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    keyMode = "vi";
    mouse = true;
    shortcut = "a";
    terminal = "tmux-256color";
    historyLimit = 5000;
    plugins = with pkgs; [
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig = "set -g @resurrect-dir '~/.tmux/resurrect'";
      }
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = "set -g @continuum-restore 'on'";
      }
      {
        plugin = tmuxPlugins.prefix-highlight;
        extraConfig = ''
          # OneDark Theme
          theme_black='#282c34'
          theme_blue='#61afef'
          theme_yellow='#e5c07b'
          theme_red='#e06c75'
          theme_white='#aab2bf'
          theme_green='#98c379'
          theme_purple='#c678dd'
          theme_cyan='#56b6c2'
          theme_orange='#d19a66'
          theme_visual_grey='#3e4452'
          theme_comment_grey='#5c6370'

          set -g @prefix_highlight_fg '$theme_black'
          set -g @prefix_highlight_bg '$theme_blue'

          set -g @prefix_highlight_empty_attr "fg=$theme_black,bg=$theme_blue"
          set -g @prefix_highlight_show_copy_mode 'on'
          set -g @prefix_highlight_copy_mode_attr "fg=$theme_black,bg=$theme_blue"
          set -g @prefix_highlight_copy_prompt "^["
          set -g @prefix_highlight_show_sync_mode 'on'
          set -g @prefix_highlight_sync_mode_attr "fg=$theme_black,bg=$theme_blue"
          set -g @prefix_highlight_sync_prompt '^↺'
        '';
      }
    ];
    extraConfig = ''
      set -as terminal-features ',xterm-256color:RGB'
      # Split panes using | and -
      bind | split-window -h
      bind - split-window -v
      unbind '"'
      unbind '%'
      bind C-x set-window-option synchronize-panes

      set -gq status 'on'
      set -gq status-justify 'left'

      set -gq status-left-length '100'
      set -gq status-right-length '100'

      set -gq status-style "fg=$theme_white,bg=$theme_black"

      set -gq window-style "fg=$theme_comment_grey"
      set -gq window-active-style "fg=$theme_white"

      set -gq display-panes-active-colour "$theme_yellow"
      set -gq display-panes-colour "$theme_blue"

      # Status panels
      set -gq status-right "#[fg=$theme_green,bg=$theme_black,nobold,nounderscore,noitalics]#[fg=$theme_black,bg=$theme_green] #h #[fg=$theme_yellow,bg=$theme_green,nobold,nounderscore,noitalics]#[fg=$theme_red,bg=$theme_yellow,nobold,nounderscore,noitalics]"
      set -gq status-left "#[fg=$theme_black,bg=$theme_green] λ #S #[fg=$theme_green,bg=$theme_black,nobold,nounderscore,noitalics]#[fg=$theme_black,bg=$theme_blue,nobold,nounderscore,noitalics]#{prefix_highlight}#[fg=$theme_blue,bg=$theme_black,nobold,nounderscore,noitalics]"

      # Window status
      set -gq window-status-format "#[fg=$theme_black,bg=$theme_visual_grey,nobold,nounderscore,noitalics]#[fg=$theme_white,bg=$theme_visual_grey,nobold] #I  #W #[fg=$theme_visual_grey,bg=$theme_black,nobold,nounderscore,noitalics]"
      set -gq window-status-current-format "#[fg=$theme_black,bg=$theme_yellow,nobold,nounderscore,noitalics]#[fg=$theme_black,bg=$theme_yellow,nobold] #I  #W #[fg=$theme_yellow,bg=$theme_black,nobold,nounderscore,noitalics]"
    '';
  };
}
