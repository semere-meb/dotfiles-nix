{
  config,
  lib,
  pkgs,
  userVars,
  ...
}:

{
  home-manager.users."${userVars.username}" = {
    programs.fuzzel = {
      enable = true;
      settings = {
        main = {
          font = "JetBrainsMono Nerd Font:size=13";
          dpi-aware = "auto";
          width = 40;
          line-height = 18;
          fields = "name,generic,comment,categories,filename,keywords";
          terminal = "foot";
        };
        colors = {
          background = "1e1e2eff";
          text = "cdd6f4ff";
          match = "f38ba8ff";
          selection = "585b70ff";
          selection-text = "cdd6f4ff";
          selection-match = "f38ba8ff";
          border = "89b4faff";
        };
        border = {
          width = 2;
          radius = 4;
        };
      };
    };
  };
}
