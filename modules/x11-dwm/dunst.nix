{
  config,
  lib,
  pkgs,
  userVars,
  ...
}:

{
  home-manager.users."${userVars.username}" = {
    services.dunst = {
      enable = true;
      settings = {
        global = {
          font = "JetBrainsMono Nerd Font 10";
          background = "#1e1e2e";
          foreground = "#cdd6f4";
          frame_color = "#89b4fa";
          separator_color = "frame";
          corner_radius = 4;
        };
      };
    };
  };
}
