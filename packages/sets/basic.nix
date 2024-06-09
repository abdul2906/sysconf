{ pkgs, ... }:

{
  security.sudo.extraConfig = ''
    Defaults  lecture="never"
  '';

  environment.systemPackages = with pkgs; [
    fastfetch
    wget
    unzip
    git
    tree
    dos2unix
  ];
}
