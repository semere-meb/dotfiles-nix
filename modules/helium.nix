{
  config,
  lib,
  pkgs,
  helium,
  ...
}:

{
  nixpkgs.overlays = [
    helium.overlays.default
  ];

  environment.systemPackages = [
    pkgs.helium
  ];
}
