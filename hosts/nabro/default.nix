{
  system = "x86_64-linux";
  configModule =
    {
      config,
      lib,
      pkgs,
      self,
      ...
    }:
    {
      imports = [
        ./hardware-configuration.nix
        self.nixosModules.desktop-suite
      ];

      networking.hostName = "nabro";
    };
}
