{
  config,
  lib,
  pkgs,
  userVars,
  ...
}:

let
  cfg = config.dotfiles.shell;

  shellDir = ./.;
  otherShellFiles = builtins.filter (
    name: name != "default.nix" && lib.strings.hasSuffix ".nix" name
  ) (builtins.attrNames (builtins.readDir shellDir));
  importedModules = map (file: shellDir + "/${file}") otherShellFiles;
in
{
  imports = importedModules;

  options.dotfiles.shell = {
    enable = lib.mkEnableOption "Shell, Git, GPG, and CLI environment";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      git
      wget
      tealdeer
      gnupg
      pass
      p7zip
      btop
      helix
      opencode
      fd
      ripgrep
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
        pinentry.package = pkgs.pinentry-qt;
      };

    };
  };
}
