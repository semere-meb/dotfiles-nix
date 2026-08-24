{
  config,
  lib,
  pkgs,
  userVars,
  ...
}:
{
  # Install KeePassXC globally.
  environment.systemPackages = with pkgs; [
    keepassxc
  ];

  # Enable the standard system-wide SSH agent.
  programs.ssh.startAgent = true;
  services.gnome.gcr-ssh-agent.enable = false;

  # Re-enable GNOME Keyring as the secret service.
  services.gnome.gnome-keyring.enable = true;

  # Disable automatic keys addition to standard SSH agent.
  programs.ssh.extraConfig = ''
    Host *
        AddKeysToAgent no
  '';
}
