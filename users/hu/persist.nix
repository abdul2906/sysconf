{ pkgs, inputs, impermanence, ... }:

{
  environment.persistence."/nix/persist".users.hu = {
    directories = [
       # Inspired by
       # https://github.com/roboyoshi/datacurator-filetree/
       "archives"
       "audio"
       "documents"
       "images"
       "games"
       "literature"
       "software"
       "video"

      # Program files
      { directory = ".gnupg"; mode = "0700"; } 
      { directory = ".ssh"; mode = "0700"; }
      { directory = ".nixops"; mode = "0700"; }
      { directory = ".local/share/keyrings"; mode = "0700"; }
      ".local/share/direnv"
      ".mozilla/firefox/shaga/bookmarkbackups"
      ".mozillla/firefox/shaga/chrome"
      ".config/Signal"
      ".config/vesktop"
      ".config/tutanota-desktop"
      ".config/tuta_integration"
      ".config/Element"
      { directory = ".pki"; mode = "0700"; }
      ".local/share/nvim"
      ".local/state/nvim"
      ".steam"
      ".local/share/steam"
    ];
    files = [
      ".mozilla/firefox/shaga/places.sqlite"
      ".mozilla/firefox/shaga/xulstore.json"
      # ".mozilla/firefox/shaga/prefs.js"
    ];
  };
}

