{ pkgs, ... }:

{
  imports = [
    ../packages/git.nix
    ../packages/nvim.nix
  ];

  environment.systemPackages = with pkgs; [
    wireshark
  ];
}
