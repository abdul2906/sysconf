{ lib }:

{
  getDirsInDir = 
    path: let
      dirs = builtins.readDir path;
    in
      builtins.filter (type: dirs.${type} == "directory") (builtins.attrNames dirs);

  getModuleImports =
    path: let
      files = builtins.attrNames (builtins.removeAttrs (builtins.readDir path) ["default.nix"]);
    in
      map (file: "${path}/${file}") files;
}

