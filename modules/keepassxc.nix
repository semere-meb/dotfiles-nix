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

  # Disable GNOME Keyring to prevent it from conflicting with KeePassXC's Secret Service Integration.
  services.gnome.gnome-keyring.enable = false;

  # Enable the standard system-level SSH agent.
  programs.ssh.startAgent = true;

  home-manager.users."${userVars.username}" = {
    # Disable GNOME Keyring in Home Manager as well.
    services.gnome-keyring.enable = false;

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
