{
  EnableTrackingProtection = {
    Value = true;
    Cryptomining = true;
    Fingerprinting = true;
    EmailTracking = true;
    Level = "strict";
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

  UserMessaging = {
    WhatsNew = false;
    ExtensionRecommendations = false;
    FeatureRecommendations = false;
    UrlbarInterventions = false;
    UrlbarTopSitesEnabled = false;
    SkipOnboarding = true;
    MoreFromMozilla = false;
  };

  FirefoxHome = {
    Search = false;
    TopSites = false;
    SponsoredTopSites = false;
    Highlights = false;
    Pocket = false;
    SponsoredPocket = false;
    Snippets = false;
    Locked = true;
  };

  SearchSuggestEnabled = false;
  NewTabPage = false;

  SearchEngines = { # ESR only
    Default = "Kagi";
    PreventInstalls = true;
    DisableSearchEngineUpdate = true;
    Remove = ["Google" "Bing" "Amazon.com" "DuckDuckGo"
              "eBay" "Twitter" "Wikipedia (en)"];
    Add = [
      {
        Name = "Kagi";
        URLTemplate = "https://kagi.com/search?q={searchTerms}";
        Method = "GET";
        IconURL = "https://kagi.com/favicon.ico";
        Alias = "@k";
        Default = true;
      }
    ];
  };

  FirefoxSuggest = {
    WebSuggestions = false;
    SponsoredSuggestions = false;
    ImproveSuggest = false;
    Locked = true;
  };
}
