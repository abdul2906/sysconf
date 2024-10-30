{ pkgs, ... }:

# You could theoretically, like I did for a while, maintain this file
# to manage your Firefox and waste your time on this or you could just use
# Firefox accounts and become a functioning member of society. This file is
# now only a starting point and will not be kept up to date with my setup.

{
  environment.persistence."/nix/persist".users.hu.directories = [
    ".mozilla/firefox/shaga"
  ];

  home-manager.users.hu = {
    programs.firefox = {
      enable = true;
      package = pkgs.firefox-esr;
      policies = {
        EnableTrackingProtection = {
          Value = true;
          Cryptomining = true;
          Fingerprinting = true;
          EmailTracking = true;
        };
        DisableTelemetry = true;
        DisablePocket = true;
        DisableFirefoxStudies = true;
        DisableFirefoxAccounts = false;
        DisableAccounts = false;
        DontCheckDefaultBrowser = true;
        OverrideFirstRunPage = "";
        OverridePostUpdatePage = "";
        NoDefaultBookmarks = true;
        Cookies = {
          Behaviour = "reject-foreign";
          BehaviourPrivateBrowsing = "reject-foreign";
        };

        SearchEngines = { # ESR only
          Remove = [ "Bing" "Google" "DuckDuckGo" "Wikipedia (en)" ];
        };

        # https://discourse.nixos.org/t/declare-firefox-extensions-and-settings/36265/17
        ExtensionSettings = with builtins;
          let extension = shortId: uuid: {
            name = uuid;
            value = {
              install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
              installation_mode = "normal_installed";
            };
          };
          in listToAttrs [
            (extension "ublock-origin" "uBlock0@raymondhill.net")
          ];

        "3rdparty".Extensions = {
          "uBlock0@raymondhill.net".adminSettings = {
            userSettings = {
              importedLists = [
                "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/LegitimateURLShortener.txt"
              ];
              externalLists = "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/LegitimateURLShortener.txt";
            };
            selectedFilterLists = [
              "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/LegitimateURLShortener.txt"
              "user-filters" "ublock-filters" "ublock-badware" "ublock-privacy" "ublock-quick-fixes"
              "ublock-unbreak" "easylist" "adguard-generic" "adguard-mobile" "easyprivacy" "adguard-spyware"
              "adguard-spyware-url" "block-lan" "urlhaus-1" "curben-phishing" "plowe-0" "dpollock-0" "fanboy-cookiemonster"
              "ublock-cookies-easylist" "adguard-cookies" "ublock-cookies-adguard" "fanboy-social" "adguard-social"
              "fanboy-thirdparty_social" "easylist-chat" "easylist-newsletters" "easylist-notifications"
              "easylist-annoyances" "adguard-mobile-app-banners" "adguard-other-annoyances" "adguard-popup-overlays"
              "adguard-widgets" "ublock-annoyances" "ALB-0" "BGR-0" "CHN-0" "CZE-0" "DEU-0" "EST-0" "ara-0" "spa-1"
              "spa-0" "FIN-0" "FRA-0" "GRC-0" "HRV-0" "HUN-0" "IDN-0" "ISR-0" "IND-0" "IRN-0" "ISL-0" "ITA-0"
              "JPN-1" "KOR-1" "LTU-0" "LVA-0" "MKD-0" "NLD-0" "NOR-0" "POL-0" "POL-2" "ROU-1" "RUS-0" "SWE-1"
              "SVN-0" "THA-0" "TUR-0" "VIE-1"
            ];
          };
        };
      };

      profiles.shaga = {
        isDefault = true;
        search = {
          force = false;
          default = "Kagi";
          order = [ "Kagi" "Gruble" "Nix Packages" "Nix Options" "Home-manager options" ];
          engines = {
            "Kagi" = {
              urls = [
                {
                  template = "https://kagi.com/search";
                  params = [
                    { name = "q"; value = "{searchTerms}"; }
                  ];
                }
              ];
              iconUpdateURL = "https://kagi.com/favicon.ico";
              updateInterval = 7 * 24 * 60 * 60 * 1000; # Weekly
              definedAliases = [ "@k" ];
            };
            "Gruble" = {
              urls = [
                {
                  template = "https://gruble.de/search";
                  params = [
                    { name = "q"; value = "{searchTerms}"; }
                  ];
                }
              ];
              iconUpdateURL = "https://gruble.de/favicon.ico";
              updateInterval = 7 * 24 * 60 * 60 * 1000; # Weekly
              definedAliases = [ "@g" ];
            };
            "Nix Packages" = {
              urls = [{
                template = "https://search.nixos.org/packages";
                params = [
                  { name = "type"; value = "packages"; }
                  { name = "channel"; value = "unstable"; }
                  { name = "query"; value = "{searchTerms}"; }
                ];
              }];
              iconUpdateURL = "https://nixos.org/favicon.png";
              updateInterval = 7 * 24 * 60 * 60 * 1000; # Weekly
              definedAliases = [ "@np" ];
            };
            "Nix Options" = {
              urls = [{
                template = "https://search.nixos.org/options";
                params = [
                  { name = "type"; value = "packages"; }
                  { name = "channel"; value = "unstable"; }
                  { name = "query"; value = "{searchTerms}"; }
                ];
              }];
              iconUpdateURL = "https://nixos.org/favicon.png";
              updateInterval = 7 * 24 * 60 * 60 * 1000; # Weekly
              definedAliases = [ "@no" ];
            };
            "Home-manager options" = {
              urls = [{
                template = "https://home-manager-options.extranix.com";
                params = [
                  { name = "release"; value = "master"; }
                  { name = "query"; value = "{searchTerms}"; }
                ];
              }];
              iconUpdateURL = "https://home-manager-options.extranix.com/images/favicon.png";
              updateInterval = 7 * 24 * 60 * 60 * 1000; # Weekly
              definedAliases = [ "@ho" ];
            };
          };
        };

        settings = {
          "browser.urlbar.quicksuggest.contextualOptIn.topPosition" = false;
          "extensions.postDownloadThirdPartyPrompt" = false;
          "extensions.getAddons.cache.enabled" = false;
          "browser.search.update" = false;
          "extensions.autoDisableScopes" = 0;
          "browser.startup.page" = 0;
          "browser.startup.homepage" = "about:blank";
          "browser.newtabpage.enabled" = false;
          "browser.newtabpage.activity-stream.showSponsored" = false;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
          "browser.newtabpage.activity-stream.default.sites" = "";
          "geo.provider.use_gpsd" = false;
          "extensions.getAddons.showPane" = false;
          "htmlaboutaddons.recommendations.enabled" = false;
          "discovery.enabled" = false;
          "browser.shopping.experience2023.enabled" = false;
          "app.shield.optoutstudies.enabled" = false;
          "app.normandy.enabled" = false;
          "app.normandy.api_url" = "";
          "breakpad.reportURL" = "";
          "browser.newtabpage.activity-stream.feeds.telemetry" = false;
          "browser.newtabpage.activity-stream.telemetry" = false;
          "browser.search.serpEventTelemetry.enabled" = false;
          "dom.security.unexpected_system_load_telemetry_enabled" = false;
          "network.trr.confirmation_telemetry_enabled" = false;
          "security.app_menu.recordEventTelemetry" = false;
          "security.certerrors.recordEventTelemetry" = false;
          "security.protectionspopup.recordEventTelemetry" = false;
          "toolkit.telemetry.bhrPing.enabled" = false;
          "toolkit.telemetry.firstShutdownPing.enabled" = false;
          "toolkit.telemetry.newProfilePing.enabled" = false;
          "toolkit.telemetry.pioneer-new-studies-available" = false;
          "toolkit.telemetry.shutdownPingSender.enabled" = false;
          "toolkit.telemetry.unified" = false;
          "toolkit.telemetry.updatePing.enabled" = false;
          "toolkit.telemetry.server" = "127.0.0.1";
          "browser.newtabpage.activity-stream.telemetry.structuredIngestion.endpoint" = "127.0.0.1";
          "browser.tabs.crashReporting.sendReport" = false;
          "browser.crashReports.unsubmittedCheck.autoSubmit2" = false;
          "captivedetect.canonicalURL" = "";
          "network.captive-portal-service.enabled" = false;
          "network.connectivity-service.enabled" = false;
          "browser.safebrowsing.downloads.remote.enabled" = false;
          "browser.urlbar.speculativeConnect.enabled" = false;
          "browser.search.suggest.enabled" = true;
          "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
          "browser.urlbar.suggest.quicksuggest.sponsored" = false;
          "browser.urlbar.suggest.searches" = true;
          "browser.urlbar.suggest.bookmark" = false;
          "browser.urlbar.suggest.addons" = false;
          "browser.urlbar.suggest.calculator" = false;
          "browser.urlbar.suggest.clipboard" = false;
          "browser.urlbar.suggest.engines" = false;
          "browser.urlbar.suggest.history" = false;
          "browser.urlbar.suggest.mdn" = false;
          "browser.urlbar.suggest.openpage" = false;
          "browser.urlbar.suggest.pocket" = false;
          "browser.urlbar.suggest.recentsearches" = false;
          "browser.urlbar.suggest.remotetab" = false;
          "browser.urlbar.suggest.topsites" = false;
          "browser.urlbar.suggest.trending" = false;
          "browser.urlbar.suggest.weather" = false;
          "browser.urlbar.suggest.yelp" = false;
          "browser.urlbar.richSuggestions.tail" = false;
          "browser.urlbar.quicksuggest.shouldShowOnboardingDialog" = false;
          "browser.urlbar.quicksuggest.rustEnabled" = false;
          "browser.urlbar.richSuggestions.featureGate" = false;
          "browser.urlbar.trending.featureGate" = false;
          "browser.urlbar.addons.featureGate" = false;
          "browser.urlbar.mdn.featureGate" = false;
          "browser.urlbar.pocket.featureGate" = false;
          "browser.urlbar.weather.featureGate" = false;
          "browser.formfill.enable" = false;
          "dom.forms.autocomplete.formautofill" = false;
          "extensions.formautofill.addresses.capture.enabled" = false;
          "extensions.formautofill.creditCards.enabled" = false;
          "signon.autofillForms" = false;
          "signon.rememberSignons" = false;
          "signon.formlessCapture.enabled" = false;
          "network.auth.subresource-http-auth-allow" = 1;
          "dom.security.https_only_mode" = true;
          "network.http.referer.XOriginTrimmingPolicy" = 2;
          "privacy.userContext.enabled" = true;
          "privacy.userContext.ui.enabled" = true;
          "privacy.sanitize.sanitizeOnShutdown" = true;
          "privacy.clearHistory.siteSettings" = true;
          "media.peerconnection.ice.no_host" = true;
          "browser.download.start_downloads_in_tmp_dir" = true;
          "browser.helperApps.deleteTempFileOnExit" = true;
          "browser.uitour.enabled" = false;
          "pdfjs.enableScripting" = false;
          "browser.download.useDownloadDir" = false;
          "browser.download.alwaysOpenPanel" = true;
          "browser.download.manager.addToRecentDocs" = false;
          "browser.download.always_ask_before_handling_new_types" = true;
          "browser.contentblocking.category" = "strict";
          "privacy.clearOnShutdown.cache" = true;
          "privacy.clearOnShutdown.downloads" = true;
          "privacy.clearOnShutdown.formdata" = true;
          "privacy.clearOnShutdown.history" = true;
          "privacy.clearOnShutdown.sessions" = true;
          "privacy.clearOnShutdown.cookies" = true;
          "privacy.clearOnShutdown.offlineApps" = true;
          "privacy.clearSiteData.historyFormDataAndDownloads" = true;
          "browser.startup.homepage_override.mstone" = "ignore";
          "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
          "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;
          "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
          "browser.messaging-system.whatsNewPanel.enabled" = false;
          "browser.urlbar.showSearchTerms.enabled" = false;
          "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts.havePinned" = "";
          "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts.searchEngines" = "";
        };
      };
    };
  };
}

