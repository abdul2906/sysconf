{ ... }:

{
  imports = let
    modules = ../../modules/nixos;
  in [
    "${modules}/hardware/nvidia"
    "${modules}/hardware/audio"
  ];
}

