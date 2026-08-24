{ pkgs, ... }:

{
  security.pam.services.swaylock = { };

  environment.systemPackages = [ pkgs.swaylock ];
}
