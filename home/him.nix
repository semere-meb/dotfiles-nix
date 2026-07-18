{ config, pkgs, ... }:
{
  home.username = "him";
  home.homeDirectory = "/home/him";
  home.stateVersion = "26.05";

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Semere M. Mebrahtom";
        email = "semere.meharena1@gmail.com";
      };
      commit.gpgsign = true;
      gpg.program = "gpg";
    };
    signing = {
      key = "451054EEC0D2AFD1741D4E6A7FC937214DF30488";
      signByDefault = true;
    };
  };

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
    pinentry.package = pkgs.pinentry-curses;
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      ll = "ls -lha";
    };
  };

  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
  };
}
