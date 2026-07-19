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
    pinentry-qt
  ];

  home-manager.users."${userVars.username}" = {
    services.gpg-agent = {
      enable = true;
      defaultCacheTtl = 1800;
      enableSshSupport = true;
      pinentry.package = pkgs.pinentry-qt;
    };
  };
}
