{ ... }:

{
  imports = let
    modules = ../../modules/nixos;
  in [
    "${modules}/core"
    "${modules}/hardware/audio"
    "${modules}/hardware/gpu/graphics.nix"
    "${modules}/multimedia"
    "${modules}/desktop/gnome"
  ];
}

