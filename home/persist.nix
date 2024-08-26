{ ... }:

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
      { directory = ".pki"; mode = "0700"; }
      ".local/share/direnv"
    ];
  };
}

