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
  x11-dwm = ./x11-dwm;
  wayland-dwl = ./wayland-dwl;

  desktop-suite = {
    imports = [
      self.nixosModules.core
      self.nixosModules.user
      self.nixosModules.desktop
      self.nixosModules.dev
      self.nixosModules.starship
      self.nixosModules.git
      # self.nixosModules.gpg
      self.nixosModules.keepassxc
      # self.nixosModules.zsh
      self.nixosModules.bash
      self.nixosModules.tmux
      self.nixosModules.helix
      # self.nixosModules.x11-dwm
      self.nixosModules.wayland-dwl
      self.nixosModules.helium
    ];
  };

  core-suite = {
    imports = [
      self.nixosModules.core
      self.nixosModules.user
      self.nixosModules.starship
      self.nixosModules.git
      self.nixosModules.gpg
      self.nixosModules.bash
      self.nixosModules.helix
      self.nixosModules.tmux
    ];
  };
}
