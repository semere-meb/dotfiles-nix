{
  config,
  lib,
  pkgs,
  userVars,
  ...
}:
let
  fzf-tab-completion = pkgs.fetchFromGitHub {
    owner = "lincheney";
    repo = "fzf-tab-completion";
    rev = "7014e0a7cd68fe3530e2f58c45740d17e98f05b8";
    hash = "sha256-qxHvd91QOv4LATikWGaL4AqEM52volP8TCYXhpZKtsA=";
  };
in
{
  programs.bash.enable = true;
  programs.bash.blesh.enable = true;

  users.users."${userVars.username}".shell = pkgs.bash;

  home-manager.users."${userVars.username}" = {
    home.file.".fzf-tab-completion".source = fzf-tab-completion;

    programs.bash = {
      enable = true;
      enableCompletion = true;

      bashrcExtra = ''
        export TERM=xterm-color
        export COLORTERM=truecolor

        # Automatically start dwm on TTY 1
        if [ -z "$DISPLAY" ] && [ -z "$WAYLAND_DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
          exec startx 2>/dev/null
        fi

        # fzf-tab-completion: makes Tab route through fzf like zsh's fzf-tab,
        # covering flags/options via bash-completion's registered completers
        source "$HOME/.fzf-tab-completion/bash/fzf-bash-completion.sh"

        if type ble-bind &>/dev/null; then
          # Sourced inside ble.sh: we use ble-bind to bind Tab
          ble-bind -x 'C-i' fzf_bash_completion
          ble-bind -x 'TAB' fzf_bash_completion
        else
          # Standard readline: bind Tab key
          bind -x '"\t": fzf_bash_completion'
        fi
      '';

      shellAliases = {
        ls = "eza --group-directories-first";
        ll = "eza -l --group-directories-first --git";
        la = "eza -la --group-directories-first --git";
        lt = "eza --tree --level=2";
        cat = "bat --paging=never";
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

    programs.zoxide = {
      enable = true;
      enableBashIntegration = true;
    };

    programs.eza = {
      enable = true;
      enableBashIntegration = true;
      icons = "auto";
    };

    programs.bat = {
      enable = true;
      config = {
        theme = "ansi";
      };
    };

    programs.direnv = {
      enable = true;
      enableBashIntegration = true;
      nix-direnv.enable = true;
    };

    programs.fzf = {
      enable = true;
      enableBashIntegration = true;
      defaultCommand = "fd --type f --hidden --exclude .git";
    };

    programs.yazi = {
      enable = true;
      enableBashIntegration = true;
    };
  };
}
