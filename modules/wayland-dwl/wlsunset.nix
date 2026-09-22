{ pkgs, ... }:

{
  environment.systemPackages = [ pkgs.wlsunset ];

  systemd.user.services.wlsunset = {
    description = "wlsunset Day/night gamma adjustments for Wayland";
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.wlsunset}/bin/wlsunset -l 52.52 -L 13.40 -t 6500 -T 4000";
    };
  };
}
