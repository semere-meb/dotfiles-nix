{
  config,
  lib,
  pkgs,
  ...
}:

{
  nixpkgs.overlays = [
    (final: prev: {
      st = prev.st.override {
        conf = builtins.readFile ./st-config.h;
      };
    })
  ];

  environment.systemPackages = [
    pkgs.st
  ];
}
