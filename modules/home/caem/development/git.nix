{ ... }:

{
  programs.git = {
    enable = true;
    userName = "caem";
    userEmail = "me@caem.dev";
    signing = {
      signByDefault = true;
      key = "E50FC66B5062070DC462661C69A830D03203405F";
    };
    extraConfig = {
      pull.rebase = true;
      init.defaultBranch = "master";
    };
  };
}
