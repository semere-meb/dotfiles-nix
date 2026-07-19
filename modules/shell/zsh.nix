{
  config,
  lib,
  pkgs,
  userVars,
  ...
}:

let
  cfg = config.dotfiles.zsh;
in
{
  options.dotfiles.zsh = {
    enable = lib.mkEnableOption "Fully configured Zsh terminal environment";
  };

  config = lib.mkIf cfg.enable {
    programs.zsh.enable = true;

    users.users."${userVars.username}".shell = pkgs.zsh;

    home-manager.users."${userVars.username}" = {
      programs.zsh = {
        enable = true;
        enableCompletion = false;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;

        dotDir = "/home/${userVars.username}/.config/zsh";

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

      programs.starship = {

        enable = true;
        enableZshIntegration = true;

        settings = {
          add_newline = false;
          command_timeout = 500;
          scan_timeout = 10;

          format = lib.concatStrings [
            "$directory"
            "$git_branch"
            "$git_status"
            "$nix_shell"
            "$python"
            "$c"
            "$rust"
            "$cmd_duration"
            "$jobs"
            "$line_break"
            "$character"
          ];

          character = {
            success_symbol = "[❯](bold green)";
            error_symbol = "[❯](bold red)";
            vimcmd_symbol = "[❮](bold yellow)";
          };

          directory = {
            style = "bold cyan";
            truncation_length = 3;
            truncate_to_repo = true;
            truncation_symbol = "…/";
            read_only = " 🔒";
          };

          git_branch = {
            style = "bold purple";
            format = "[$symbol$branch]($style) ";
            symbol = " ";
          };

          git_status = {
            style = "bold red";
            format = "([$all_status$ahead_behind]($style)) ";
            conflicted = "=";
            ahead = "⇡\${count}";
            behind = "⇣\${count}";
            diverged = "⇕⇡\${ahead_count}⇣\${behind_count}";
            staged = "+\${count}";
            modified = "!\${count}";
            untracked = "?\${count}";
            stashed = "\$";
          };

          nix_shell = {
            style = "bold blue";
            format = "[$symbol$state( \($name\))]($style) ";
            symbol = "❄ ";
            impure_msg = "impure";
            pure_msg = "pure";
          };

          python = {
            style = "bold yellow";
            format = "[$symbol( \($virtualenv\))]($style) ";
            symbol = " ";
            detect_extensions = [ "py" ];
            detect_files = [
              "pyproject.toml"
              "requirements.txt"
              "uv.lock"
            ];
          };

          c = {
            style = "bold dimmed white";
            format = "[$symbol($version(-$name))]($style) ";
            symbol = " ";
            detect_extensions = [
              "c"
              "h"
            ];
          };

          rust = {
            disabled = true;
          };

          cmd_duration = {
            style = "bold yellow";
            format = "[$duration]($style) ";
            min_time = 2000;
            show_notifications = false;
          };

          jobs = {
            style = "bold blue";
            symbol = "✦";
            number_threshold = 1;
          };

          aws.disabled = true;
          gcloud.disabled = true;
          docker_context.disabled = true;
          kubernetes.disabled = true;
          package.disabled = true;
          battery.disabled = true;
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
    };
  };
}
