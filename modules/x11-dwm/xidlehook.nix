{ pkgs, ... }:

{
  environment.systemPackages = [ pkgs.xidlehook ];

  systemd.user.services.xidlehook = {
    description = "xidlehook screen locker and suspender";
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.xidlehook}/bin/xidlehook --detect-sleep --not-when-fullscreen --timer 300 '${pkgs.slock}/bin/slock' '${pkgs.pipewire}/bin/pw-cli ls-output | ${pkgs.gnugrep}/bin/grep -q running' --timer 600 'systemctl suspend' '' --timer 1500 'systemctl hibernate' ''";
    };
  };
}
