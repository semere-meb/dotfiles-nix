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
      defaultCacheTtl = 7200;
      defaultCacheTtlSsh = 7200;
      maxCacheTtl = 28800;
      maxCacheTtlSsh = 28800;
      enableSshSupport = true;
      pinentry.package = pkgs.pinentry-gnome3;
    };
  };
}
