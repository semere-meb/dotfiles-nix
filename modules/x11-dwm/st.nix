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
        patches = [
          (pkgs.fetchpatch {
            url = "https://st.suckless.org/patches/scrollback-reflow-standalone/st-scrollback-reflow-standalone-0.9.3.diff";
            sha256 = "sha256-QLig9iae6woVGEsiruJdyZCG7ZdycPzl/NcXP9e08tI=";
          })
        ];
      };
    })
  ];

  environment.systemPackages = [
    pkgs.st
  ];
}
