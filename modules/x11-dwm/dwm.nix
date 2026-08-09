{
  config,
  lib,
  pkgs,
  userVars,
  ...
}:

{
  services.xserver = {
    enable = true;

    xkb = {
      layout = "us";
      variant = "";
      options = "ctrl:swapcaps";
    };

    windowManager.dwm = {
      enable = true;
      package = pkgs.dwm.override {
        conf = builtins.readFile ./dwm-config.h;
        patches = [
        ];
      };
    };

    displayManager.startx.enable = true;
  };

  environment.systemPackages = with pkgs; [
    dmenu
    xclip
    xkill
  ];

  services.picom = {
    enable = true;
  };

  home-manager.users."${userVars.username}" = {
    # Set up .xinitrc to launch slstatus and dwm
    home.file.".xinitrc".text = ''
      dunst &

      exec dwm
    '';
  };
}
