{ pkgs, ... }:

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

        [gpg]
          program = "${pkgs.gnupg}/bin/gpg2"

        [commit]
          gpgSign = true

        [tag]
          gpgSign = true

        [init]
          defaultBranch = "master"

        [pull]
          rebase = true
      '';
    };

    home.file."/home/hu/.config/git/uni" = {
      source = ugp;
    };

    home.file."/home/hu/.config/git/config" = {
      text = ''
        [includeIf "gitdir:~/programming/personal/**"]
          path = ~/.config/git/personal

        [includeIf "gitdir:~/programming/forks/**"]
          path = ~/.config/git/personal

        [includeIf "gitdir:~/programming/uni/**"]
          path = ~/.config/git/uni
      '';
    };
  };
}

