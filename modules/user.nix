{ config, lib, pkgs, ... }:

let
  cfg = config.dotfiles.user;
in
{
  options.dotfiles.user = {
    enable = lib.mkEnableOption "User configuration";
  };

  config = lib.mkIf cfg.enable {
    users.users.semere = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "networkmanager"
      ];
    };

    home-manager.users.semere = {
      home.username = "semere";
      home.homeDirectory = "/home/semere";
      home.stateVersion = "26.05";
    };
  };
}
