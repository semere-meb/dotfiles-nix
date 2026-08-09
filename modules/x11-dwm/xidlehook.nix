{
  config,
  lib,
  pkgs,
  userVars,
  ...
}:

{
  home-manager.users."${userVars.username}" = {
    services.xidlehook = {
      enable = true;
      detect-sleep = true;
      not-when-fullscreen = true;
      not-when-audio = true;
      timers = [
        {
          delay = 300;
          command = "${pkgs.slock}/bin/slock";
        }
      ];
    };
  };
}
