{
  config,
  lib,
  pkgs,
  ...
}:

{
  # maim is a minimal, modern replacement for scrot under X11
  environment.systemPackages = with pkgs; [
    maim
  ];
}
