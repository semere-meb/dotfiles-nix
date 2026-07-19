{
  config,
  lib,
  pkgs,
  userVars,
  ...
}:

{
  programs.dwl.enable = true;
  programs.dwl.package = pkgs.dwl.override {
    configH = ../hosts/nabro/dwl-config.h;
  };

  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    jack.enable = true;
  };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    noto-fonts
    noto-fonts-color-emoji
  ];

  fonts.fontconfig.defaultFonts = {
    monospace = [
      "JetBrainsMono Nerd Font"
      "Noto Sans Mono"
    ];
    emoji = [ "Noto Color Emoji" ];
  };

  hardware.graphics.enable = true;
  security.polkit.enable = true;
  programs.dconf.enable = true;
  security.pam.services.swaylock = { };

  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };

  services.getty.autologinUser = "${userVars.username}";

  environment.systemPackages = with pkgs; [
    pamixer
    brightnessctl
    wl-clipboard
    wmenu
    fnott
    foot
    firefox
    tor-browser
    grim
    slurp
    wlopm
  ];

  home-manager.users."${userVars.username}" = {
    gtk = {
      enable = true;
      theme = {
        name = "Adwaita-dark";
        package = pkgs.gnome-themes-extra;
      };
      gtk3.extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
      gtk4.extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
    };

    programs.foot = {
      enable = true;
      settings = {
        main = {
          font = "JetBrainsMono Nerd Font:size=13";
        };
      };
    };

    programs.swaylock = {
      enable = true;
      package = pkgs.swaylock-effects;
      settings = {
        clock = true;
        indicator = true;
        screenshots = true;
        effect-blur = "7x5";
        effect-vignette = "0.5:0.5";
        ring-color = "b085f5";
        key-hl-color = "5e35b1";
        line-color = "00000000";
        inside-color = "00000088";
        separator-color = "00000000";
        fade-in = 0.2;
      };
    };

    services.swayidle = {
      enable = true;
      events = {
        before-sleep = "${pkgs.swaylock-effects}/bin/swaylock -f";
        lock = "${pkgs.swaylock-effects}/bin/swaylock -f";
      };
      timeouts = [
        {
          timeout = 300;
          command = "${pkgs.swaylock-effects}/bin/swaylock -f";
        }
        {
          timeout = 600;
          command = "${pkgs.wlopm}/bin/wlopm --off '*'";
          resumeCommand = "${pkgs.wlopm}/bin/wlopm --on '*'";
        }
        {
          timeout = 900;
          command = "${pkgs.systemd}/bin/systemctl hibernate";
        }
      ];
    };

    services.wlsunset = {
      enable = true;
      latitude = "52.5";
      longitude = "13.4";
      temperature = {
        day = 6500;
        night = 4000;
      };
    };

    services.fnott = {
      enable = true;
      settings = {
        main = {
          font = "JetBrainsMono Nerd Font:size=11";
          background = "1a1a24e0";
          border-color = "b085f5ff";
          border-size = 2;
          padding-vertical = 12;
          padding-horizontal = 16;
          summary-color = "ffffffff";
          body-color = "e0e0e0ff";
        };
      };
    };
  };
}
