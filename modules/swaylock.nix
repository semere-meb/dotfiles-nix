{
  config,
  lib,
  pkgs,
  userVars,
  ...
}:

{
  security.pam.services.swaylock = {};

  home-manager.users."${userVars.username}" = {
    programs.swaylock = {
      enable = true;
      settings = {
        color = "1e1e2e";
        ring-color = "89b4fa";
        key-hl-color = "f38ba8";
        line-color = "00000000";
        inside-color = "1e1e2e";
        separator-color = "00000000";
        text-color = "cdd6f4";
      };
    };
  };
}
