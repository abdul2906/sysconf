{ pkgs, ... }:

{
  imports = [
    ../packages/git.nix
    ../packages/nvim.nix
  ];

  environment.systemPackages = with pkgs; [
    wireshark
    seer
    mars-mips
  ];

  users.users.hu.extraGroups = [ "wireshark" ];
}

