{
  config,
  lib,
  pkgs,
  ...
}:

{
  # Setuid wrapper is required for slock to verify password
  programs.slock.enable = true;
}
