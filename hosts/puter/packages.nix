{ ... }:

{
  imports = let
    modules = ../../modules/nixos;
  in [
    "${modules}/core"
    "${modules}/hardware/audio"
    "${modules}/hardware/gpu/nvidia"
    "${modules}/hardware/cpu/amd"
    "${modules}/multimedia"
    "${modules}/desktop/gnome"
    "${modules}/communication"
    "${modules}/development"
  ];
}

