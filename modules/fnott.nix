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
          title-font = "JetBrainsMono Nerd Font:size=11";
          summary-font = "JetBrainsMono Nerd Font:size=11";
          body-font = "JetBrainsMono Nerd Font:size=11";
          background = "1a1a24e0";
          border-color = "b085f5ff";
          border-size = 2;
          min-width = 450;
          progress-bar-height = 14;
          progress-color = "b085f5cc";
          padding-vertical = 12;
          padding-horizontal = 16;
          summary-color = "ffffffff";
          body-color = "e0e0e0ff";
        };
      };
    };
  };
}
