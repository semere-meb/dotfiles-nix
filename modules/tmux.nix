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
      # Ensure st terminal features like 24-bit truecolor support work properly
      set -ag terminal-overrides ",st-256color:Tc"
      set -as terminal-features ",st-256color:RGB"

      # Renumber windows when one is closed
      set -g renumber-windows on

      # Status bar design matching Helix (Ayu Dark) with sharp corner style
      set -g status-position bottom
      set -g status-justify left
      set -g status-style "bg=#1f2430,fg=#b3b1ad"

      # Pane borders matching Ayu Dark
      set -g pane-border-style "fg=#242936,bg=#0f1419"
      set -g pane-active-border-style "fg=#ffb454,bg=#0f1419"

      # Message/command line styling
      set -g message-style "bg=#1f2430,fg=#ffb454,bold"

      # Window status formatting (rectangular/sharp style)
      set -g window-status-separator ""
      set -g window-status-format "#[fg=#b3b1ad,bg=#1f2430] #I:#W #[fg=#5c6773,bg=#1f2430]│"
      set -g window-status-current-format "#[fg=#ffb454,bg=#2d3744,bold] #I:#W #[fg=#5c6773,bg=#1f2430]│"

      # Status Left: Session info with sharp corner block
      set -g status-left-length 50
      set -g status-left "#[fg=#0f1419,bg=#39bae6,bold] ❐ #S #[fg=#39bae6,bg=#1f2430,none] │"

      # Status Right: Date, Time, and Host with sharp corner blocks and vertical separator │
      set -g status-right-length 100
      set -g status-right "#[fg=#5c6773,bg=#1f2430]│#[fg=#7fd962,bg=#1f2430] %Y-%m-%d #[fg=#5c6773]│#[fg=#ffb454,bg=#1f2430,bold] %H:%M #[fg=#5c6773,bg=#1f2430,none]│#[fg=#0f1419,bg=#39bae6,bold] #H "
    '';
  };
}
