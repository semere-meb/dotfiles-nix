{
  config,
  lib,
  pkgs,
  userVars,
  ...
}:

{
  home-manager.users."${userVars.username}".programs.tmux = {
    enable = true;
    keyMode = "vi";
    shortcut = "b";
    terminal = "tmux-256color";
    historyLimit = 10000;
    mouse = true;
    escapeTime = 0;
    baseIndex = 1;

    extraConfig = ''
      # ----- Status Bar And Optics -----

      # status bar
      set -g status-position bottom
      set -g status-interval 1
      set -g status-style bg=#1a1a1a,fg=#B4B4B4

      # left: session name
      set -g status-left "#[bg=#FF8C64,fg=#000000] #S #[bg=#1a1a1a,fg=#FF8C64]  "
      set -g status-left-length 30

      # right: directory, hostname, time
      set -g status-right "#[fg=#B4B4B4]#{pane_current_path}  #[fg=#FF8C64]#{host}  #[bg=#FF8C64,fg=#000000] %H:%M:%S "
      set -g status-right-length 200

      # windows
      set -g window-status-format "#[fg=#666666] #I:#W "
      set -g window-status-current-format "#[fg=#FF8C64] #I:#W "
      set -g window-status-separator ""

      # pane borders
      set -g pane-border-style fg=#7A5C4A
      set -g pane-active-border-style fg=#7A5C4A

      # active pane
      # set -g pane-border-status top
      # set -g pane-border-format "#{?pane_active,#[fg=#FF8C64]●,}"

      # dim inactive panes
      # set -g window-style 'fg=#666666,bg=#111111'
      # set -g window-active-style 'fg=#B4B4B4,bg=#1a1a1a'

      # set -g window-style 'bg=#111111'
      # set -g window-active-style 'bg=#1a1a1a'

      # ----- Misc -----

      # reload
      bind r source-file ~/.config/tmux/tmux.conf \; display "reloaded"

      # ----- Nested Session Toggle -----
      # Ctrl-k (no prefix) toggles outer tmux off so keys pass through to inner tmux.
      # Press Ctrl-k again to restore outer tmux control.
      bind-key -n C-k \
        set-option prefix None \;\
        set-option key-table off \;\
        set-option status-left "#[bg=#666666,fg=#000000] #S #[bg=#1a1a1a,fg=#666666]  " \;\
        set-option status-right "#[fg=#666666]#{pane_current_path}  #[fg=#666666]#{host}  #[bg=#666666,fg=#000000] %H:%M:%S " \;\
        set-option window-status-current-format "#[fg=#666666] #I:#W " \;\
        if -F '#{pane_in_mode}' 'send-keys -X cancel' \;\
        refresh-client -S

      bind-key -T off C-k \
        set-option -u prefix \;\
        set-option -u key-table \;\
        set-option -u status-left \;\
        set-option -u status-right \;\
        set-option -u window-status-current-format \;\
        refresh-client -S
    '';
  };
}
