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

  home-manager.users."${userVars.username}" = {
    services.gpg-agent = {
      enable = true;
      defaultCacheTtl = 86400;
      defaultCacheTtlSsh = 86400;
      maxCacheTtl = 86400;
      maxCacheTtlSsh = 86400;
      enableSshSupport = false;
      pinentry.package = pkgs.pinentry-gnome3;
    };
  };
}
