{
  description = "NixOS system flake";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-26.05";
    };
    helium = {
      url = "github:oxcl/nix-flake-helium-browser";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      helium,
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
          specialArgs = {
            inherit userVars self helium;
          };
          modules = [
            hostConfig.configModule
          ];
        }
      );
    in
    {
      inherit nixosConfigurations;
      nixosModules = import ./modules { inherit lib self; };
    };
}
