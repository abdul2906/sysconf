{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    age
  ];

  shellHook = ''
    alias nix="nix --experimental-features 'nix-command flakes'"
  '';
}

