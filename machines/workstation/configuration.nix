{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./persist.nix
    ../../packages/sets/basic.nix
    ../../packages/wm/hyprland.nix
    ../../users/hu/user.nix
  ];

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    device = "nodev";
    gfxmodeEfi = "1920x1080";
  };
  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;
  boot.supportedFilesystems = [ "btrfs" "xfs" ];

  networking = {
    hostName = "workstation";
    enableIPv6 = false;
    nameservers = [ "9.9.9.9" ];
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
    keyMap = "uk";
    # useXkbConfig = true;
  };

  nixpkgs.config.allowUnfree = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware = {
    opengl = {
      enable = true;
      driSupport32Bit = true;
    };
    nvidia = {
      modesetting.enable = true;
      nvidiaSettings = true;
      powerManagement.enable = true;
      package = config.boot.kernelPackages.nvidiaPackages.beta;
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

  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  networking.firewall = {
    allowedTCPPorts = [ 25565 ];
    allowedUDPPorts = [ 25565 ];
  };

  system.stateVersion = "23.11";
}

