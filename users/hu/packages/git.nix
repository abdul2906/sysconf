{ config, lib, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "caem";
    userEmail = "caem@dirae.org";
    signing = {
      key = "D125101DC74D392FEFDFD54AF4F7229F8B860E9F";
      signByDefault = true;
    };
  };
}
