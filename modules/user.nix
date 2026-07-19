{
  config,
  lib,
  pkgs,
  userVars,
  ...
}:

let
  cfg = config.dotfiles.user;
in
{
  options.dotfiles.user = {
    enable = lib.mkEnableOption "User configuration";
  };

  config = lib.mkIf cfg.enable {
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
  };
}
