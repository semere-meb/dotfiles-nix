{ config, lib, pkgs, userVars, ... }:

let
  cfg = config.dotfiles.shell;
in
{
  options.dotfiles.shell = {
    enable = lib.mkEnableOption "Shell, Git, GPG, and CLI environment";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      git
      wget
      tree
      tealdeer
      gnupg
      pass
      p7zip
      btop
      helix
      opencode
    ];

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

      programs.helix = {
        enable = true;
        settings = {
          editor = {
            line-numbers = "relative";
            lsp.display-messages = true;
          };
        };
      };
    };
  };
}
