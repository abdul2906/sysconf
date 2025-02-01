{ pkgs, config, ... }:

let
  # Has to be >= 29 due to treesitter
  emacsPkg = "emacs30";
in {
  services.emacs = {
    enable = true;
    package = pkgs."${emacsPkg}"; 
    defaultEditor = true;
  };

  programs.emacs = {
    enable = true;
    package = (pkgs."${emacsPkg}-pgtk".pkgs.withPackages (epkgs: [
      epkgs.treesit-grammars.with-all-grammars
    ]));
  };

  home.file."${config.xdg.configHome}/emacs".source = ./emacs.d;
}
