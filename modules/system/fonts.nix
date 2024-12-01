{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    nerd-fonts.go-mono
  ];
}

