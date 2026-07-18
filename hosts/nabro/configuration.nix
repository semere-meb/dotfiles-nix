{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules
  ];

  networking.hostName = "nabro";

  # Enable host-specific feature branches (dendrites)
  dotfiles = {
    core.enable = true;
    user.enable = true;
    desktop.enable = true;
    dev.enable = true;
    shell.enable = true;
  };
}
