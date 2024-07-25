{ lib }:

# todo: Write a function to import all of these automatically

let
  fs = import ./fs.nix { inherit lib; };
  hosts = import ./hosts.nix { inherit lib; };
in
  fs // hosts

