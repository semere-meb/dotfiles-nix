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
}
