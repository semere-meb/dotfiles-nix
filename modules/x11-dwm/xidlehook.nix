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

      timers = [
        {
          delay = 300;
          command = "${pkgs.slock}/bin/slock";
          canceller = "${pkgs.pipewire}/bin/pw-cli ls-output | ${pkgs.gnugrep}/bin/grep -q running";
        }
        {
          delay = 600;
          command = "systemctl suspend";
        }
        {
          delay = 1500;
          command = "systemctl hibernate";
        }
      ];
    };
  };
}
