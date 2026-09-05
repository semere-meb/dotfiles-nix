{ pkgs, userVars, ... }:

{
  programs.git = {
    enable = true;
    config = {
      user = {
        name = userVars.fullName;
        email = userVars.email;
        signingkey = "key::${userVars.sshKey}";
      };
      commit = {
        gpgSign = true;
      };
      gpg = {
        format = "ssh";
      };
    };
  };
}
