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

  home-manager.users."${userVars.username}" = {
    # Re-enable GNOME Keyring in Home Manager.
    services.gnome-keyring.enable = true;

    # Disable automatic keys addition to standard SSH agent using the modern settings option.
    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;
      settings = {
        "*" = {
          AddKeysToAgent = "no";
        };
      };
    };
    # Configure KeePassXC native messaging hosts for Firefox and Zen Browser.
    # This enables the browser extension to communicate with KeePassXC.
    home.file = {
      # ".mozilla/native-messaging-hosts/org.keepassxc.keepassxc_browser.json".text = builtins.toJSON {
      #   allowed_extensions = [ "keepassxc-browser@keepassxc.org" ];
      #   description = "KeePassXC integration with Mozilla Firefox";
      #   name = "org.keepassxc.keepassxc_browser";
      #   path = "${pkgs.keepassxc}/bin/keepassxc-proxy";
      #   type = "stdio";
      # };
      # ".config/zen/native-messaging-hosts/org.keepassxc.keepassxc_browser.json".text = builtins.toJSON {
      #   allowed_extensions = [ "keepassxc-browser@keepassxc.org" ];
      #   description = "KeePassXC integration with Zen Browser";
      #   name = "org.keepassxc.keepassxc_browser";
      #   path = "${pkgs.keepassxc}/bin/keepassxc-proxy";
      #   type = "stdio";
      # };
    };
  };
}
