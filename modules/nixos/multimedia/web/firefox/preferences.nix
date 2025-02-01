let
  prefToString = value:
    if builtins.isBool value then
      if value then "true" else "false"
    else if (builtins.isInt value) || (builtins.isNull value) then
      builtins.toString value
    else if builtins.isString value then
      ''"${value}"''
    else
      builtins.throw
        "Pref expected one of (Bool, String, Int, Null) got instead ${builtins.typeOf value}";

  mkPrefs = prefs: builtins.concatStringsSep 
    "\n"
    (builtins.attrValues
      (builtins.mapAttrs
        (n: v: ''pref("${n}", ${prefToString v});'') prefs));
in 
  mkPrefs {
    "browser.urlbar.suggest.topsites" = false;
    "browser.startup.homepage" = "about:blank";
    "browser.download.useDownloadDir" = false;
  }
