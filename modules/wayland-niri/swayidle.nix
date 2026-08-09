{
  config,
  lib,
  pkgs,
  userVars,
  ...
}:

{
  home-manager.users."${userVars.username}" = {
    services.swayidle = {
      enable = true;
      events = {
        before-sleep = "${pkgs.swaylock}/bin/swaylock -f";
        lock = "${pkgs.swaylock}/bin/swaylock -f";
      };
      timeouts = [
        {
          timeout = 300;
          command = "${pkgs.swaylock}/bin/swaylock -f";
        }
        {
          timeout = 600;
          command = "niri msg action power-off-monitors";
        }
      ];
    };
  };
}
