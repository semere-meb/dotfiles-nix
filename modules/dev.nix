{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.dotfiles.dev;
in
{
  options.dotfiles.dev = {
    enable = lib.mkEnableOption "Development tools and language servers";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      gcc
      gnumake
      clang-tools
      lldb
      python3
      uv
      ruff
      ty
      nil
      nixd
      nixfmt
    ];
  };
}
