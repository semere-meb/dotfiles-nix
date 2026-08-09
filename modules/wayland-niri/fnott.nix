{
  config,
  lib,
  pkgs,
  userVars,
  ...
}:

{
  home-manager.users."${userVars.username}" = {
    services.fnott = {
      enable = true;
      settings = {
        main = {
          background = "1e1e2eff";
          border-color = "89b4faff";
          border-size = 2;
          border-radius = 4;
          title-font = "JetBrainsMono Nerd Font:size=13:weight=bold";
          title-color = "cdd6f4ff";
          summary-font = "JetBrainsMono Nerd Font:size=13";
          summary-color = "cdd6f4ff";
          body-font = "JetBrainsMono Nerd Font:size=13";
          body-color = "cdd6f4ff";
        };
      };
    };
  };
}
