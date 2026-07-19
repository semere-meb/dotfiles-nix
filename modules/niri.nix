{
  config,
  lib,
  pkgs,
  userVars,
  ...
}:

{
  programs.niri.enable = true;

  home-manager.users."${userVars.username}" = {
    xdg.configFile."niri/config.kdl".text = ''
      prefer-no-csd

      workspace "browser"
      workspace "term"

      input {
          keyboard {
              xkb {
                  options "ctrl:swapcaps"
              }
          }

          touchpad {
              tap
              dwt
              natural-scroll
          }

          mouse {
          }
      }

      output "eDP-1" {
      }

      layout {
          gaps 12
          center-focused-column "never"
          default-column-width { proportion 0.5; }

          preset-column-widths {
              proportion 0.333
              proportion 0.5
              proportion 0.667
          }

          focus-ring {
              width 2
          }
      }

      spawn-at-startup "fnott"

      binds {
          Mod+Shift+Slash { show-hotkey-overlay; }

          Mod+H     { focus-column-left; }
          Mod+L     { focus-column-right; }
          Mod+J     { focus-window-or-workspace-down; }
          Mod+K     { focus-window-or-workspace-up; }

          Mod+1 { focus-workspace "browser"; }
          Mod+2 { focus-workspace "term"; }
          Mod+3 { focus-workspace 3; }
          Mod+4 { focus-workspace 4; }
          Mod+5 { focus-workspace 5; }
          Mod+6 { focus-workspace 6; }
          Mod+7 { focus-workspace 7; }
          Mod+8 { focus-workspace 8; }
          Mod+9 { focus-workspace 9; }

          Mod+Shift+H     { move-column-left; }
          Mod+Shift+L     { move-column-right; }
          Mod+Shift+J     { move-window-down; }
          Mod+Shift+K     { move-window-up; }

          Mod+Shift+1 { move-column-to-workspace "browser"; }
          Mod+Shift+2 { move-column-to-workspace "term"; }
          Mod+Shift+3 { move-column-to-workspace 3; }
          Mod+Shift+4 { move-column-to-workspace 4; }
          Mod+Shift+5 { move-column-to-workspace 5; }
          Mod+Shift+6 { move-column-to-workspace 6; }
          Mod+Shift+7 { move-column-to-workspace 7; }
          Mod+Shift+8 { move-column-to-workspace 8; }
          Mod+Shift+9 { move-column-to-workspace 9; }

          Mod+Q { close-window; }
          Mod+F { maximize-column; }
          Mod+Shift+F { fullscreen-window; }
          Mod+Space { switch-preset-column-width; }

          Mod+Return { spawn "foot"; }
          Mod+D      { spawn "fuzzel"; }
          Mod+B      { spawn "zen-beta"; }
          Mod+E      { spawn "foot" "yazi"; }
          Mod+Alt+L { spawn "swaylock"; }
          Mod+Shift+Q { quit; }

          Mod+V       { toggle-window-floating; }
          Mod+Shift+V { switch-focus-between-floating-and-tiling; }

          Mod+O repeat=false { toggle-overview; }

          Mod+BracketLeft  { consume-or-expel-window-left; }
          Mod+BracketRight { consume-or-expel-window-right; }
          Mod+Comma        { consume-window-into-column; }
          Mod+Period       { expel-window-from-column; }

          XF86AudioRaiseVolume  { spawn "~/.config/fnott/scripts/osd.sh" "volume" "raise"; }
          XF86AudioLowerVolume  { spawn "~/.config/fnott/scripts/osd.sh" "volume" "lower"; }
          XF86AudioMute         { spawn "~/.config/fnott/scripts/osd.sh" "volume" "mute"; }
          XF86MonBrightnessUp   { spawn "~/.config/fnott/scripts/osd.sh" "brightness" "raise"; }
          XF86MonBrightnessDown { spawn "~/.config/fnott/scripts/osd.sh" "brightness" "lower"; }

          Print { screenshot; }
          Mod+Print { screenshot-screen; }
          Mod+Shift+S { screenshot; }
      }

      window-rule {
          match app-id=r#"^zen.*$"#
          open-on-workspace "browser"
      }

      window-rule {
          match app-id="^foot$"
          open-on-workspace "term"
      }
    '';
  };
}
