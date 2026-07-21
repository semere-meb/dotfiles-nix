{ lib, self, ... }:
let
  moduleDirectoryList = builtins.filter (
    name: name != "default.nix" && lib.strings.hasSuffix ".nix" name
  ) (builtins.attrNames (builtins.readDir ./.));

  allModules = builtins.listToAttrs (
    map (entry: {
      name = lib.strings.removeSuffix ".nix" entry;
      value = ./. + "/${entry}";
    }) moduleDirectoryList
  );
in
allModules
// {
  desktop-suite = {
    imports = [
      self.nixosModules.core
      self.nixosModules.user
      self.nixosModules.desktop
      self.nixosModules.dev
      self.nixosModules.starship
      self.nixosModules.git
      self.nixosModules.gpg
      self.nixosModules.zsh
      self.nixosModules.helix
      self.nixosModules.zen-browser
      self.nixosModules.niri
      self.nixosModules.noctalia
      # self.nixosModules.fuzzel
      # self.nixosModules.fnott
      # self.nixosModules.swaylock
      # self.nixosModules.swayidle
      # self.nixosModules.wlsunset
    ];
  };

  core-suite = {
    imports = [
      self.nixosModules.core
      self.nixosModules.user
      self.nixosModules.starship
      self.nixosModules.git
      self.nixosModules.gpg
      self.nixosModules.zsh
      self.nixosModules.helix
    ];
  };
}
