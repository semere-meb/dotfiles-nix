{
  config,
  lib,
  pkgs,
  userVars,
  ...
}:

{
  home-manager.users."${userVars.username}" = {
    programs.zen-browser = {
      enable = true;
      setAsDefaultBrowser = true;

      policies = {
        ExtensionSettings = {
          # uBlock Origin
          "uBlock0@raymondhill.net" = {
            installation_mode = "force_installed";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          };
          # Decentraleyes
          "jid1-BoFifL9Vbdl2zQ@jetpack" = {
            installation_mode = "force_installed";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/decentraleyes/latest.xpi";
          };
          # Vimium
          "{d7742d87-e61d-4b78-b8a1-b469842139fa}" = {
            installation_mode = "force_installed";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/vimium-ff/latest.xpi";
          };
        };
      };

      profiles.default = {
        id = 0;
        isDefault = true;
        name = "default";

        search = {
          force = true;
          default = "Brave";
          engines = {
            "Brave" = {
              urls = [ { template = "https://search.brave.com/search?q={searchTerms}"; } ];
              icon = "https://search.brave.com/favicon.ico";
              updateInterval = 24 * 60 * 60 * 1000; # every day
              definedAliases = [ "@b" ];
            };
          };
        };

        settings = {
          "browser.startup.homepage" = "about:blank";
          "browser.newtabpage.enabled" = false;
          "network.trr.mode" = 2; # DoH first, fallback to native DNS
          "network.trr.uri" = "https://all.dns.mullvad.net/dns-query";
          "network.trr.custom_uri" = "https://all.dns.mullvad.net/dns-query";
          "zen.view.compact" = true;
          "browser.compactmode.show" = true;
          "browser.uidensity" = 1;
          # "layout.css.devPixelsPerPx" = "-1";
          # "browser.ctrlTab.recentlyUsedOrder" = true;
          # "browser.ctrlTab.previews" = true;

          # Privacy & Security Settings
          "browser.contentblocking.category" = "strict";
          "dom.security.https_only_mode" = true;

          # Password and Autofill Disable
          "signon.rememberSignons" = false;
          "signon.autofillForms" = false;
          "signon.generation.enabled" = false;
          "signon.management.page.breach-alerts.enabled" = false;
          "browser.formfill.enable" = false;
          "extensions.formautofill.addresses.enabled" = false;
          "extensions.formautofill.creditCards.enabled" = false;
          "extensions.formautofill.heuristics.enabled" = false;
        };
      };
    };
  };
}
