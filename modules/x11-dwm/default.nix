{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./dwm.nix
    ./st.nix
    ./dunst.nix
    ./slock.nix
    ./xidlehook.nix
    ./maim.nix
  ];
}
