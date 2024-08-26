{ config, pkgs, ... }:

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
        DisableFirefoxAccounts = true;
        DisableAccounts = true;
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

        ExtensionSettings = {
          "wikipedia@search.mozilla.org" = {
            installation_mode = "blocked";
          };

          "google@search.mozilla.org" = {
            installation_mode = "blocked";
          };

          "bing@search.mozilla.org" = {
            installation_mode = "blocked";
          };

          "ddg@search.mozilla.org" = {
            installation_mode = "blocked";
          };
        };

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
              "user-filters"
              "ublock-filters"
              "ublock-badware"
              "ublock-privacy"
              "ublock-quick-fixes"
              "ublock-unbreak"
              "easylist"
              "adguard-generic"
              "adguard-mobile"
              "easyprivacy"
              "adguard-spyware"
              "adguard-spyware-url"
              "block-lan"
              "urlhaus-1"
              "curben-phishing"
              "plowe-0"
              "dpollock-0"
              "fanboy-cookiemonster"
              "ublock-cookies-easylist"
              "adguard-cookies"
              "ublock-cookies-adguard"
              "fanboy-social"
              "adguard-social"
              "fanboy-thirdparty_social"
              "easylist-chat"
              "easylist-newsletters"
              "easylist-notifications"
              "easylist-annoyances"
              "adguard-mobile-app-banners"
              "adguard-other-annoyances"
              "adguard-popup-overlays"
              "adguard-widgets"
              "ublock-annoyances"
              "ALB-0"
              "BGR-0"
              "CHN-0"
              "CZE-0"
              "DEU-0"
              "EST-0"
              "ara-0"
              "spa-1"
              "spa-0"
              "FIN-0"
              "FRA-0"
              "GRC-0"
              "HRV-0"
              "HUN-0"
              "IDN-0"
              "ISR-0"
              "IND-0"
              "IRN-0"
              "ISL-0"
              "ITA-0"
              "JPN-1"
              "KOR-1"
              "LTU-0"
              "LVA-0"
              "MKD-0"
              "NLD-0"
              "NOR-0"
              "POL-0"
              "POL-2"
              "ROU-1"
              "RUS-0"
              "SWE-1"
              "SVN-0"
              "THA-0"
              "TUR-0"
              "VIE-1"
            ];
          };
        };
      };

      profiles.shaga = {
        isDefault = true;
        search = {
          force = true;
          default = "Gruble";
          order = [ "Gruble" "Nix Packages" "Nix Options" "Home-manager options" ];
          engines = {
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

        extensions = with config.nur.repos.rycee.firefox-addons; [
          ublock-origin
          image-search-options
          bitwarden
          translate-web-pages
          tampermonkey
        ];

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
          "browser.search.suggest.enabled" = false;
          "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
          "browser.urlbar.suggest.quicksuggest.sponsored" = false;
          "browser.urlbar.suggest.searches" = false;
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

          # https://github.com/elFarto/nvidia-vaapi-driver?tab=readme-ov-file#firefox
          "media.ffmpeg.vaapi.enabled" = true;
          "media.rdd-ffmpeg.enabled" = true;
          "media.av1.enabled" = false;

          # Options for the firefox-ui-fix using Photon
          # https://github.com/black7375/Firefox-UI-Fix/blob/master/user.js
          "userChrome.tab.connect_to_window" = true;
          "userChrome.tab.color_like_toolbar" = true;
          "userChrome.tab.lepton_like_padding" = false;
          "userChrome.tab.photon_like_padding" = true;
          "userChrome.tab.dynamic_separator" = false;
          "userChrome.tab.static_separator" = true; 
          "userChrome.tab.static_separator.selected_accent" = false;
          "userChrome.tab.newtab_button_like_tab" = false;
          "userChrome.tab.newtab_button_smaller" = true;
          "userChrome.tab.newtab_button_proton" = false;
          "userChrome.icon.panel_full" = false;
          "userChrome.icon.panel_photon" = true;
          "userChrome.icon.panel_sparse" = false;
          "userChrome.tab.box_shadow" = false;
          "userChrome.tab.bottom_rounded_corner" = false;
          "userChrome.tab.photon_like_contextline" = true;
          "userChrome.rounding.square_tab" = true;
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "svg.context-properties.content.enabled" = true;
          "browser.compactmode.show" = true;
          "browser.newtabpage.activity-stream.improvesearch.handoffToAwesomebar" = false;
          "layout.css.has-selector.enabled" = true;
          "userChrome.compatibility.theme" = true;
          "userChrome.compatibility.os" = true;
          "userChrome.theme.built_in_contrast" = true;
          "userChrome.theme.system_default" = true;
          "userChrome.theme.proton_color" = true;
          "userChrome.theme.proton_chrome" = true;
          "userChrome.theme.fully_color" = true;
          "userChrome.theme.fully_dark" = true;
          "userChrome.decoration.cursor" = true;
          "userChrome.decoration.field_border" = true;
          "userChrome.decoration.download_panel" = true;
          "userChrome.decoration.animate" = true;
          "userChrome.padding.tabbar_width" = true;
          "userChrome.padding.tabbar_height" = true;
          "userChrome.padding.toolbar_button" = true;
          "userChrome.padding.navbar_width" = true;
          "userChrome.padding.urlbar" = true;
          "userChrome.padding.bookmarkbar" = true;
          "userChrome.padding.infobar" = true;
          "userChrome.padding.menu" = true;
          "userChrome.padding.bookmark_menu" = true;
          "userChrome.padding.global_menubar" = true;
          "userChrome.padding.panel" = true;
          "userChrome.padding.popup_panel" = true;
          "userChrome.tab.multi_selected" = true;
          "userChrome.tab.unloaded" = true;
          "userChrome.tab.letters_cleary" = true;
          "userChrome.tab.close_button_at_hover" = true;
          "userChrome.tab.sound_hide_label" = true;
          "userChrome.tab.sound_with_favicons" = true;
          "userChrome.tab.pip" = true;
          "userChrome.tab.container" = true;
          "userChrome.tab.crashed" = true;
          "userChrome.fullscreen.overlap" = true;
          "userChrome.fullscreen.show_bookmarkbar" = true;
          "userChrome.icon.library" = true;
          "userChrome.icon.panel" = true;
          "userChrome.icon.menu" = true;
          "userChrome.icon.context_menu" = true;
          "userChrome.icon.global_menu" = true;
          "userChrome.icon.global_menubar" = true;
          "userChrome.icon.1-25px_stroke" = true;
          "userContent.player.ui" = true;
          "userContent.player.icon" = true;
          "userContent.player.noaudio" = true;
          "userContent.player.size" = true;
          "userContent.player.click_to_play" = true;
          "userContent.player.animate" = true;
          "userContent.newTab.full_icon" = true;
          "userContent.newTab.animate" = true;
          "userContent.newTab.pocket_to_last" = true;
          "userContent.newTab.searchbar" = true;
          "userContent.page.field_border" = true;
          "userContent.page.illustration" = true;
          "userContent.page.proton_color" = true;
          "userContent.page.dark_mode" = true;
          "userContent.page.proton" = true;
        };
      };
    };
  };
}

