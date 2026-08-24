{ pkgs, ... }:

{
  environment.systemPackages = [ pkgs.swayidle ];

  systemd.user.services.swayidle = {
    description = "swayidle Idle manager for Wayland";
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.swayidle}/bin/swayidle -w timeout 300 '${pkgs.swaylock}/bin/swaylock -f' timeout 600 'niri msg action power-off-monitors' before-sleep '${pkgs.swaylock}/bin/swaylock -f' lock '${pkgs.swaylock}/bin/swaylock -f'";
    };
  };
}
