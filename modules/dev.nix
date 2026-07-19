{
  config,
  lib,
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    tealdeer
    opencode
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
