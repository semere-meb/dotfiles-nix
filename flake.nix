{
  description = "NixOS system flake";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-26.05";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
  let
    lib = nixpkgs.lib;
  in
  {
    nixosConfigurations = {
      nabro = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/nabro/configuration.nix

          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;



              backupFileExtension = "backup";
            };
          }
        ];
      };
    };
  };
}
