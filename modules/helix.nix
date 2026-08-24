{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    helix
  ];

  environment.variables.EDITOR = "hx";
  environment.variables.VISUAL = "hx";
}
