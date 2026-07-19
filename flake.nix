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

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      zen-browser,
      ...
    }:
    let
      lib = nixpkgs.lib;
      userVars = import ./vars.nix;

      hostsDir = ./hosts;
      hostNames = builtins.attrNames (
        lib.filterAttrs (name: type: type == "directory") (builtins.readDir hostsDir)
      );

      nixosConfigurations = lib.genAttrs hostNames (
        name:
        let
          hostConfig = import (./hosts + "/${name}");
        in
        lib.nixosSystem {
          system = hostConfig.system;
          specialArgs = { inherit userVars self zen-browser; };
          modules = [
            hostConfig.configModule
          ]
          ++ [
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = { inherit userVars self zen-browser; };
                backupFileExtension = "backup";
                sharedModules = [
                  zen-browser.homeModules.default
                ];
              };
            }
          ];
        }
      );
    in
    {
      inherit nixosConfigurations;
      nixosModules = import ./modules { inherit lib self; };
    };
}
