{
  config,
  lib,
  pkgs,
  ...
}:

{
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
}
