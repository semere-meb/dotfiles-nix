{
  config,
  lib,
  pkgs,
  userVars,
  ...
}:

{
  home-manager.users."${userVars.username}" = {
    programs.helix = {
      enable = true;
      defaultEditor = true;

      settings = {
        theme = "ayu_dark";
        editor = {
          line-number = "relative";
          mouse = false;
          color-modes = true;
          auto-format = true;
          completion-timeout = 5;
          completion-replace = true;
          preview-completion-insert = true;
          scrolloff = 8;
          cursorline = true;
          auto-info = true;
          rulers = [ 80 ];
          bufferline = "multiple";
          shell = [
            "zsh"
            "-c"
          ];
          jump-label-alphabet = "asdfghjklqwertyuiopzxcvbnm";

          cursor-shape = {
            insert = "bar";
            normal = "block";
            select = "underline";
          };

          inline-diagnostics = {
            cursor-line = "warning";
            other-lines = "disable";
          };

          file-picker = {
            hidden = false;
            git-ignore = true;
            git-global = true;
          };

          statusline = {
            left = [
              "mode"
              "file-base-name"
              "version-control"
            ];
            center = [ ];
            right = [
              "diagnostics"
              "selections"
              "position"
              "file-encoding"
              "file-type"
            ];
            separator = "│";
          };

          lsp = {
            display-messages = true;
            display-inlay-hints = true;
          };

          indent-guides = {
            render = true;
            character = "╎";
            skip-levels = 1;
          };

          soft-wrap = {
            enable = false;
          };

          smart-tab = {
            enable = true;
            supersede-menu = true;
          };
        };
      };

      languages = {
        language = [
          {
            name = "python";
            language-servers = [
              "ty"
              "ruff"
            ];
            formatter = {
              command = "ruff";
              args = [
                "format"
                "-"
              ];
            };
            auto-format = true;
          }
          {
            name = "c";
            language-servers = [ "clangd" ];
            formatter = {
              command = "clang-format";
              args = [ "--style=file" ];
            };
            auto-format = true;
          }
          {
            name = "nix";
            language-servers = [ "nixd" ];
            formatter = {
              command = "nixfmt";
            };
            auto-format = true;
          }
        ];

        language-server = {
          nixd = {
            command = "nixd";
          };
          ruff = {
            command = "ruff";
          };
          ty = {
            command = "ty";
            args = [ "server" ];
          };
          clangd = {
            command = "clangd";
          };
        };
      };
    };
  };
}
