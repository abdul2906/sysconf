{ lib }:

{
  getDirsInDir = 
    path: let
      dirs = builtins.readDir path;
    in
      builtins.filter (name: dirs.${name} == "directory") (builtins.attrNames dirs);
}

