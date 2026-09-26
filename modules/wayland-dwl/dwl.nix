{
  config,
  lib,
  pkgs,
  userVars,
  ...
}:

{
  programs.dwl = {
    enable = true;
    package = pkgs.dwl.override {
      configH = ./dwl_config.h;
    };
  };

  environment.systemPackages = with pkgs; [
    wmenu
    mako
    wl-clipboard
    swaylock
    grim
    slurp
  ];

  systemd.user.services = {
    wlsunset = {
      description = "wlsunset Day/night gamma adjustments for Wayland";
      wantedBy = [ "graphical-session.target" ];
      partOf = [ "graphical-session.target" ];
      serviceConfig = {
        ExecStart = "${pkgs.wlsunset}/bin/wlsunset -l 52.52 -L 13.40 -t 6500 -T 4000";
      };
    };
    swayidle = {
      description = "swayidle Idle manager for Wayland";
      wantedBy = [ "graphical-session.target" ];
      partOf = [ "graphical-session.target" ];
      serviceConfig = {
        ExecStart = "${pkgs.swayidle}/bin/swayidle -w timeout 300 '${pkgs.swaylock}/bin/swaylock -f' before-sleep '${pkgs.swaylock}/bin/swaylock -f' lock '${pkgs.swaylock}/bin/swaylock -f'";
      };
    };
  };
}
