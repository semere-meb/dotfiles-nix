{ config, lib, pkgs, userVars, ... }:

let
  cfg = config.dotfiles.desktop;
in
{
  options.dotfiles.desktop = {
    enable = lib.mkEnableOption "Graphical desktop environment (DWL)";
  };

  config = lib.mkIf cfg.enable {
    programs.dwl.enable = true;
    programs.dwl.package = pkgs.dwl.override {
      configH = ../hosts/nabro/dwl-config.h;
    };

    services.pipewire = {
      enable = true;
      pulse.enable = true;
      alsa.enable = true;
      jack.enable = true;
    };

    fonts.packages = with pkgs; [
      nerd-fonts.jetbrains-mono
    ];

    hardware.graphics.enable = true;
    security.polkit.enable = true;

    environment.systemPackages = with pkgs; [
      pamixer
      brightnessctl
      wl-clipboard
      wmenu
      fnott
      foot
      firefox
      tor-browser
    ];

    home-manager.users."${userVars.username}" = {
      programs.foot = {
        enable = true;
        settings = {
          main = {
            font = "JetBrainsMono Nerd Font:size=11";
          };
        };
      };
    };
  };
}
