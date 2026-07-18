{ config, lib, pkgs, ... }:

let
  cfg = config.dotfiles.core;
in
{
  options.dotfiles.core = {
    enable = lib.mkEnableOption "Core system configuration";
  };

  config = lib.mkIf cfg.enable {
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.kernelPackages = pkgs.linuxPackages_latest;

    time.timeZone = "Europe/Berlin";

    networking.networkmanager.enable = true;

    services.power-profiles-daemon.enable = true;

    nix = {
      settings = {
        experimental-features = [ "nix-command" "flakes" ];
        auto-optimise-store = true;
      };
      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
      };
    };

    system.stateVersion = "26.05";
  };
}
