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
        bindkey -e

        bindkey '^A' beginning-of-line
        bindkey '^E' end-of-line

        bindkey '^B' backward-char
        bindkey '^F' forward-char
        bindkey '^[b' backward-word
        bindkey '^[f' forward-word

        bindkey '^H' backward-delete-char
        bindkey '^D' delete-char
        bindkey '^W' backward-kill-word
        bindkey '^[d' kill-word

        bindkey '^K' kill-line
        bindkey '^U' backward-kill-line
        bindkey '^Y' yank

        bindkey '^T' transpose-chars
        bindkey '^L' clear-screen

        # Ctrl+Left / Ctrl+Right (word movement)
        bindkey '^[[1;5D' backward-word
        bindkey '^[[1;5C' forward-word
        bindkey '^[OD' backward-word
        bindkey '^[OC' forward-word
        bindkey '^[[5D' backward-word
        bindkey '^[[5C' forward-word
        bindkey '^[^[[D' backward-word
        bindkey '^[^[[C' forward-word

        # Alt+Left / Alt+Right
        bindkey '^[[1;3D' backward-word
        bindkey '^[[1;3C' forward-word

        # Home / End keys
        bindkey '^[[H' beginning-of-line
        bindkey '^[[F' end-of-line
        bindkey '^[OH' beginning-of-line
        bindkey '^[OF' end-of-line
        bindkey '^[[1~' beginning-of-line
        bindkey '^[[4~' end-of-line

        # Delete key
        bindkey '^[[3~' delete-char

        # Ctrl+Delete
        bindkey '^[[3;5~' kill-word

        # # Import Wayland environment to systemd for GUI tools (like pinentry-gnome3)
        # if [ -n "$WAYLAND_DISPLAY" ]; then
        #   systemctl --user import-environment WAYLAND_DISPLAY DISPLAY DBUS_SESSION_BUS_ADDRESS 2>/dev/null
        #   dbus-update-activation-environment --systemd WAYLAND_DISPLAY DISPLAY DBUS_SESSION_BUS_ADDRESS 2>/dev/null
        # fi
        export TERM=xterm-256color
        export COLORTERM=truecolor

        # Automatically start dwm on TTY 1
        if [ -z "$DISPLAY" ] && [ -z "$WAYLAND_DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
          exec startx 2>/dev/null
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
        nd = "nix develop -c $SHELL";
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
