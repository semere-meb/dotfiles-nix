{
  description = "NixOS system flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-26.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
  let
    system = "x86_64-linux";

    hosts = [ "sys" ];
    # hosts = builtins.attrNames (builtins.readDir ./hosts);
  in
  {
    nixosConfigurations =
      builtins.listToAttrs (
        map (host: {
          name = host;
          value = nixpkgs.lib.nixosSystem {
            inherit system;

            modules = [
              ./hosts/${host}/configuration.nix
              ./hosts/${host}/hardware-configuration.nix

              home-manager.nixosModules.home-manager
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;

                  users.him = import ./home/him.nix;

                  backupFileExtension = "backup";
                };
              }
            ];
          };
        }) hosts
      );
  };
}
