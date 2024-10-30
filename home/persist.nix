{ ... }:

{
  environment.persistence."/nix/persist".users.hu = {
    directories = [
      "archives"
      "documents"
      "programming"
      "source"
      "games"
      "images"
      "videos"

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

