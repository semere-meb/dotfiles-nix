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
    userVars = import ./vars.nix;

    hostsDir = ./hosts;
    hostNames = builtins.attrNames (
      lib.filterAttrs (name: type: type == "directory") (builtins.readDir hostsDir)
    );

    nixosConfigurations = lib.genAttrs hostNames (name:
      let
        hostConfig = import (./hosts + "/${name}");
      in
      lib.nixosSystem {
        system = hostConfig.system;
        specialArgs = { inherit userVars; };
        modules = [ hostConfig.configModule ] ++ [
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit userVars; };
              backupFileExtension = "backup";
            };
          }
        ];
      }
    );
  in
  {
    inherit nixosConfigurations;
  };
}
