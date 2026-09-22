{
  config,
  lib,
  pkgs,
  userVars,
  ...
}:

{
  programs.dwl = {
    enable = true;
    package = pkgs.dwl.override {
      configH = ./dwl_config.h;
    };
  };

  environment.systemPackages = with pkgs; [
    wmenu
    grim
    slurp
    wl-clipboard
    foot
  ];
}
