{
  config,
  lib,
  pkgs,
  userVars,
  ...
}:

{
  programs.zsh.enable = true;

  users.users."${userVars.username}".shell = pkgs.zsh;

  environment.systemPackages = with pkgs; [
    fzf
    zoxide
    direnv
    nix-direnv
    yazi
    eza
    bat
    starship
    zsh-autosuggestions
    zsh-fast-syntax-highlighting
    zsh-history-substring-search
    zsh-fzf-tab
  ];
}
