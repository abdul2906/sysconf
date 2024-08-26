{ pkgs, ... }:

{
  environment.persistence."/nix/persist".users.hu.directories = [
    ".local/share/nvim"
    ".local/state/nvim"
  ];

  environment.variables = {
    EDITOR = "nvim";
  };

  home-manager.users.hu = {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      extraPackages = with pkgs; [
        lua-language-server
        nodePackages.intelephense
        nodePackages.typescript-language-server
        clang-tools
        ripgrep
        nil
        gcc
        basedpyright
        rust-analyzer
        zathura
        git
        texliveFull
        luajitPackages.jsregexp
        luajitPackages.luarocks
        fd
        texlab
        haskell-language-server
      ];
    };

    home.file."/home/hu/.config/nvim" = {
      source = ../../dotfiles/nvim;
      recursive = true;
    };
  };
}

