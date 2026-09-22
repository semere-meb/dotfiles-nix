{ pkgs, ... }:

{
  environment.systemPackages = [ pkgs.swayidle ];

  systemd.user.services.swayidle = {
    description = "swayidle Idle manager for Wayland";
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.swayidle}/bin/swayidle -w timeout 300 '${pkgs.swaylock}/bin/swaylock -f' before-sleep '${pkgs.swaylock}/bin/swaylock -f' lock '${pkgs.swaylock}/bin/swaylock -f'";
    };
  };
}
