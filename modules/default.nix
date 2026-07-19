{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./core.nix
    ./user.nix
    ./desktop.nix
    ./dev.nix
    ./shell
  ];
}
