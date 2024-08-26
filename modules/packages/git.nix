{ ... }:

{
  home-manager.users.hu = {
    programs.git = {
      enable = true;

      userName = "caem";
      userEmail = "me@caem.dev";
      signing = {
        key = "E50FC66B5062070DC462661C69A830D03203405F";
        signByDefault = true;
      };

      extraConfig = {
        init.defaultBranch = "master";
      };
    };
  };
}

