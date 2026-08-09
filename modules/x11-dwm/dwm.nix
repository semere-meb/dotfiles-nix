{
  config,
  lib,
  pkgs,
  userVars,
  ...
}:

{
  services.xserver = {
    enable = true;

    # Configure keymap
    xkb = {
      layout = "us";
      variant = "";
      options = "ctrl:swapcaps";
    };

    # Enable suckless dwm window manager
    windowManager.dwm = {
      enable = true;
      package = pkgs.dwm.override {
        conf = builtins.readFile ./dwm-config.h;
        patches = [
        ];
      };
    };

    # Enable startx for minimal TTY login flow
    displayManager.startx.enable = true;
  };

  # Install suckless utilities and X11 helper tools
  environment.systemPackages = with pkgs; [
    dmenu
    slstatus
    xclip
    xorg.xkill
  ];

  home-manager.users."${userVars.username}" = {
    # Set up .xinitrc to launch slstatus and dwm
    home.file.".xinitrc".text = ''
      # Start status bar
      slstatus &

      # Start the window manager
      exec dwm
    '';
  };
}
