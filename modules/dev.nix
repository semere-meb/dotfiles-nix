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

    # c/c++
    gcc
    gnumake
    clang-tools
    lldb

    # python
    python3
    uv
    ruff
    ty

    # nix
    nil
    nixd
    nixfmt
    eza
    zk

    # terminal
    foot
    tmux
    helix

    # git
    git
    lazygit
    gh
    diff-so-fancy
  ];
}
