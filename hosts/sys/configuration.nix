{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "sys";

  networking.networkmanager.enable = true;

  services.power-profiles-daemon.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    jack.enable = true;
  };

  time.timeZone = "Europe/Berlin";
  users.users.him = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
  };

  environment.systemPackages = with pkgs; [
    pamixer
    brightnessctl
    wl-clipboard

    gcc
    gnumake
    clang-tools
    lldb
    python3
    uv
    ruff
    ty

    nil
    nixd

    git
    wget
    tree
    tealdeer
    gnupg
    pass
    p7zip
    yazi
    wmenu
    fnott

    btop

    wlock
    helix
    foot
    firefox

    mpv
    yt-dlp
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  programs.dwl.enable = true;
  programs.dwl.package = pkgs.dwl.override {
    configH = ./dwl-config.h;
  };

  hardware.graphics.enable = true;
  security.polkit.enable = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = pkgs.pinentry-curses;
  };

  system.stateVersion = "26.05";

}
