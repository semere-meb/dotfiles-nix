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
}
