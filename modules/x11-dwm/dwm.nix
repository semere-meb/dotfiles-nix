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
    # xkb = {
    #   layout = "us";
    #   variant = "";
    #   options = "ctrl:swapcaps";
    # };
    windowManager.dwm = {
      enable = true;
      package = pkgs.dwm.override {
        conf = builtins.readFile ./dwm-config.h;
        patches = [ ];
      };
    };
  };

  services.displayManager.ly.enable = true;
  services.displayManager.defaultSession = "none+dwm";

  services.picom = {
    enable = true;
    backend = "glx";
    vSync = true;
  };

  services.dunst.enable = true;

  environment.systemPackages = with pkgs; [
    dmenu
    xclip
    xkill
  ];
}
