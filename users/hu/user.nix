{ config, pkgs, ... }:

{
  imports = [
    ../../modules/desktop/apps/communication.nix
    ../../modules/desktop/apps/games.nix
    ../../modules/desktop/apps/multimedia.nix
    ./persist.nix
    ./packages/nh.nix
    ./packages/zsh/zsh.nix
    ./packages/virt-manager.nix
  ];

  environment.variables = {
    ZDOTDIR = "/home/hu/.config/zsh";
    EDITOR = "nvim";
  };

  users.users.hu = {
    isNormalUser = true;
    extraGroups = [ "wheel" "libvirtd" ];
    shell = pkgs.zsh;
    hashedPasswordFile = "/nix/config/secrets/hu/pass";
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.hu = {
      home.username = "hu";
      home.homeDirectory = "/home/hu";
      home.stateVersion = config.system.stateVersion;

      imports = [
        ./packages/zsh/zsh-home.nix
        ./packages/git.nix
        ./packages/gtk.nix
        ./packages/hyprland.nix
        ./packages/foot.nix
        ./packages/firefox.nix
        ./packages/rofi.nix
        ./packages/fastfetch.nix
        ./packages/nvim/neovim.nix
        ./packages/waybar.nix
        ./packages/virt-manager-home.nix
      ];
    };
  };
}

