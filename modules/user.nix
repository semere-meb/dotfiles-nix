{
  config,
  lib,
  pkgs,
  userVars,
  ...
}:

{
  users.users."${userVars.username}" = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
  };

  home-manager.users."${userVars.username}" = {
    home.username = userVars.username;
    home.homeDirectory = "/home/${userVars.username}";
    home.stateVersion = "26.05";
  };
}
