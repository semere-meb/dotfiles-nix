{
  config,
  lib,
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    wget
    tealdeer
    p7zip
    btop
    opencode
    fd
    ripgrep
  ];
}
