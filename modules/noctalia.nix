{
  config,
  lib,
  pkgs,
  userVars,
  noctalia,
  ...
}:

{
  imports = [
    noctalia.nixosModules.default
  ];

  programs.noctalia = {
    enable = true;
    recommendedServices.enable = true;
  };

  home-manager.users."${userVars.username}" = {
    imports = [
      noctalia.homeModules.default
    ];

    programs.noctalia = {
      enable = true;
      systemd.enable = true;

      settings = {
        global = {
          launch_apps_as_systemd_services = true;
        };

        theme = {
          mode = "dark";
          source = "community";
          community_palette = "Ayu";
        };

        bar = {
          order = [ "main" ];
          main = {
            enabled = true;
            position = "top";
            auto_hide = false;
            smart_auto_hide = true;
            reserve_space = false;
            # margin_ends = 0;
          };
        };

        location = {
          auto_locate = false;
          address = "Berlin, Germany";
          latitude = 52.5200;
          longitude = 13.4050;
        };

        nightlight = {
          enabled = true;
          schedule = "automatic";
        };

        battery = {
          warning_threshold = 15;
        };

        idle = {
          pre_action_fade_seconds = 2.0;
          behavior = {
            lock = {
              timeout = 300;
              action = "lock";
              enabled = true;
            };
            screen-off = {
              timeout = 600;
              action = "screen_off";
              enabled = true;
            };
            hibernate = {
              timeout = 900;
              action = "command";
              command = "systemctl hibernate";
              enabled = true;
            };
          };
        };
      };
    };
  };
}
