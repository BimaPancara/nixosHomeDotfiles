{ pkgs, ... }:

{
  home.username = "apokaliph";
  home.homeDirectory = "/home/apokaliph";
  home.stateVersion = "26.05";

  home.sessionVariables = {
    XDG_CURRENT_DESKTOP = "niri";
  };

  imports = [
    # Desktop environment
    ./desktop.nix

    # Package categories
    ./dev.nix
    ./multimedia.nix
    ./kde.nix
    ./gaming.nix
    ./utils.nix

    # Shell and terminal
    ./shell.nix
    ./terminal.nix

    # Services
    ./services.nix

    # Applications
    ./emacs.nix
    ./game.nix
  ];
}
