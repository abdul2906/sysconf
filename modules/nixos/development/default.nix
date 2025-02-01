{ username, ... }:

{
  environment.persistence."/nix/persist" = {
    users."${username}".directories = [
      ".local/share/emacs"
    ];
  };
}