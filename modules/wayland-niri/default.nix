{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./niri.nix
    ./fuzzel.nix
    ./swaylock.nix
    ./swayidle.nix
    ./fnott.nix
    ./wlsunset.nix
  ];
}
