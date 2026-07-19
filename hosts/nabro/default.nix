{
  system = "x86_64-linux";
  configModule =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      imports = [
        ./hardware-configuration.nix
        ../../modules
      ];

      networking.hostName = "nabro";

      dotfiles = {
        core.enable = true;
        user.enable = true;
        desktop.enable = true;
        dev.enable = true;
        shell.enable = true;
        zsh.enable = true;
        helix.enable = true;
      };
    };
}
