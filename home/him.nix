{ config, pkgs, ... } :
{
  home.username = "him";
  home.homeDirectory = "/home/him";
  home.stateVersion = "26.05";

  programs.git.enable = true;

  programs.bash = {
    enable = true;
    shellAliases = {
      ll = "ls -lha";
    };
  };

}

