{
  config,
  lib,
  pkgs,
  userVars,
  ...
}:

{
  home-manager.users."${userVars.username}" = {
    programs.git = {
      enable = true;
      settings = {
        user = {
          name = userVars.fullName;
          email = userVars.email;
        };
        commit.gpgsign = true;
        gpg.program = "gpg";
      };
      signing = {
        key = userVars.gpgKey;
        signByDefault = true;
      };
    };
  };
}
