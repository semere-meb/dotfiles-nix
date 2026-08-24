{
  config,
  lib,
  pkgs,
  userVars,
  ...
}:

{
  programs.bash.enable = true;
  programs.bash.enableLsColors = true;
  programs.bash.completion.enable = true;

  users.users."${userVars.username}".shell = pkgs.bash;

  environment.shellAliases = {
    grep = "grep --color=auto";
    gs = "git status -sb";
    gd = "git diff";
    gc = "git commit";
    gp = "git push";
    ga = "git add -A";
    gm = "git add -m";
    gl = "git log --oneline";
    cleanup = "sudo nix-collect-garbage -d";
    ".." = "cd ..";
    "..." = "cd ../..";
  };
}
