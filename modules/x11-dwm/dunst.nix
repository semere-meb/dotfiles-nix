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
          background = "#1e1e2e";
          foreground = "#cdd6f4";
          separator_color = "frame";
          corner_radius = 4;
          width = 300;
          height = 300;
          offset = "30x50";
          origin = "top-right";
          transparency = 10;
          frame_color = "#89b4fa";
          font = "Droid Sans 9";
        };

        urgency_low = {
          background = "#0f1419";
          foreground = "#5c6773";
          frame_color = "#1f2430";
          timeout = 5;
        };

        urgency_normal = {
          background = "#0f1419";
          foreground = "#e6e1cf";
          frame_color = "#39bae6";
          timeout = 8;
        };

        urgency_critical = {
          background = "#0f1419";
          foreground = "#f07178";
          frame_color = "#ff3333";
          timeout = 0;
        };
      };
    };
  };
}
