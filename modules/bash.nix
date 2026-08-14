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
  programs.bash.enableCompletion = true;

  users.users."${userVars.username}".shell = pkgs.bash;

  home-manager.users."${userVars.username}" = {

    programs.bash = {
      enable = true;

      shellAliases = {
        # ls = "eza --group-directories-first";
        # ll = "eza -l --group-directories-first --git";
        # la = "eza -la --group-directories-first --git";
        # lt = "eza --tree --level=2";
        # cat = "bat --paging=never";
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
    };

    # programs.eza = {
    #   enable = true;
    #   enableBashIntegration = true;
    #   icons = "auto";
    # };

  };
}
