{ pkgs, lib, ... }:

let
  ugp = "/nix/config/secrets/git_uni";
in {
  home-manager.users.hu = {
    home.file."/home/hu/.config/git/personal" = {
      text = ''
        [user]
          email = "me@caem.dev"
          name = "caem"
          signingKey = "E50FC66B5062070DC462661C69A830D03203405F"

        [tag]
          gpgSign = true

        [init]
          defaultBranch = "master"

        [pull]
          rebase = true
      '';
    };

    home.file."/home/hu/.config/git/uni" = (lib.mkIf (builtins.pathExists ugp) {
      source = "/nix/config/secrets/git_uni";
    });

    home.file."/home/hu/.config/git/config" = {
      text = ''
        [gpg]
          program = "${pkgs.gnupg}/bin/gpg2"

        [includeIf "gitdir:~/programming/personal/**"]
          path = ~/.config/git/personal

        [includeIf "gitdir:~/programming/forks/**"]
          path = ~/.config/git/personal

      '' + (if builtins.pathExists ugp then ''
        [includeIf "gitdir:~/programming/uni/**"]
          path = ~/.config/git/uni

      '' else ''
        # Uni config omitted
      '');
    };
  };
}

