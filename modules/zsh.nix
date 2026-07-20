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

  home-manager.users."${userVars.username}" = {
    programs.zsh = {
      enable = true;
      enableCompletion = false;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      dotDir = "/home/${userVars.username}/.config/zsh";

      initContent = ''
        # -- GPG / SSH Configuration --
        export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"

        # Import Wayland environment to systemd for GUI tools (like pinentry-gnome3)
        if [ -n "$WAYLAND_DISPLAY" ]; then
          systemctl --user import-environment WAYLAND_DISPLAY DISPLAY DBUS_SESSION_BUS_ADDRESS 2>/dev/null
          dbus-update-activation-environment --systemd WAYLAND_DISPLAY DISPLAY DBUS_SESSION_BUS_ADDRESS 2>/dev/null
        fi

        # Automatically start niri on TTY 1
        if [ -z "$DISPLAY" ] && [ -z "$WAYLAND_DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
          exec niri-session
        fi
      '';

      history = {
        size = 10000;
        save = 10000;
        path = "$HOME/.local/share/zsh/history";
        ignoreDups = true;
        ignoreAllDups = true;
        ignoreSpace = true;
        share = true;
        extended = true;
      };

      plugins = [
        {
          name = "fast-syntax-highlighting";
          src = pkgs.zsh-fast-syntax-highlighting.src;
        }
        {
          name = "zsh-autosuggestions";
          src = pkgs.zsh-autosuggestions.src;
        }
        {
          name = "zsh-history-substring-search";
          src = pkgs.zsh-history-substring-search.src;
        }
        {
          name = "fzf-tab";
          src = pkgs.zsh-fzf-tab.src;
        }
      ];

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
      enableZshIntegration = true;
    };

    programs.eza = {
      enable = true;
      enableZshIntegration = true;
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
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    programs.fzf = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      defaultCommand = "fd --type f --hidden --exclude .git";
    };

    programs.yazi = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
