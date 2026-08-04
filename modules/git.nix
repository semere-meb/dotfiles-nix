{
  config,
  lib,
  pkgs,
  userVars,
  ...
}:

let
  useSshSigning = userVars ? sshKey && userVars.sshKey != "";
in
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
      } // (if useSshSigning then {
        gpg.format = "ssh";
      } else {
        gpg.program = "gpg";
      });
      signing = {
        key = if useSshSigning then userVars.sshKey else userVars.gpgKey;
        signByDefault = true;
      };
    };
  };
}
