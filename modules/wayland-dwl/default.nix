{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./dwl.nix
    ./swaylock.nix
    ./swayidle.nix
    ./fnott.nix
    ./wlsunset.nix
  ];
}
