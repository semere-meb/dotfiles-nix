{
  config,
  lib,
  pkgs,
  userVars,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    gnupg
    pass
    pinentry-gnome3
  ];

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = false;
    pinentryPackage = pkgs.pinentry-gnome3;
    extraConfig = ''
      default-cache-ttl 86400
      default-cache-ttl-ssh 86400
      max-cache-ttl 86400
      max-cache-ttl-ssh 86400
    '';
  };
}
