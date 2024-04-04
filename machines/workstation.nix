{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware/workstation.nix
    ./persist/workstation.nix
    ../wm/xmonad.nix
    ../packages/sets/basic.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.supportedFilesystems = [ "btrfs" "xfs" ];

  networking = {
    hostName = "workstation";
    enableIPv6 = false;
    nameservers = [ "1.1.1.1" ];
    defaultGateway = "192.168.2.1";
    interfaces.enp34s0.ipv4.addresses = [{
      address = "192.168.2.68";
      prefixLength = 24;
    }];
  };

  time.timeZone = "Europe/Berlin";

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

  nixpkgs.config.allowUnfree = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
    nvidia = {
      modesetting.enable = true;
      nvidiaSettings = true;
      open = false;
      package = config.boot.kernelPackages.nvidiaPackages.production;
    };
  };

  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    jack.enable = true;
  };

  # Todo: Move these packages out in the correct files.
  environment.systemPackages = with pkgs; [
    neovim
  ];

  system.stateVersion = "23.11";
}

