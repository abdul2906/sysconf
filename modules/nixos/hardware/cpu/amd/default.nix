{ pkgs, ... }:

{
  boot = {
    kernelModules = [ "kvm-amd" ];
    extraModprobeConfig = "options kvm_amd nested=1";
  };

  hardware.cpu.amd.updateMicrocode = true;
  hardware.firmware = with pkgs; [ linux-firmware ];
}
