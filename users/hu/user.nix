{ config, pkgs, ... }:

{
  imports = [
    ../../packages/sets/communication.nix
    ../../packages/sets/games.nix
    ./persist.nix
    ./packages/nh.nix
    ./packages/zsh/zsh.nix
  ];

  environment.variables = {
    ZDOTDIR = "/home/hu/.config/zsh";
    EDITOR = "nvim";
  };

  users.users.hu = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
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
        ./packages/ags/ags.nix
      ];
    };
  };
}

