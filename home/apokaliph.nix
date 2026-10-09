
{ pkgs, ... }:

{
  home.username = "apokaliph";
  home.homeDirectory = "/home/apokaliph";
  
  home.stateVersion = "26.05";
  
  # Add Packages
  home.packages = with pkgs; [
    fastfetch
  ];
  
  # Link Config
  # Fastfetch
  xdg.configFile."fastfetch/config.jsonc".source =
    ./dotfiles/fastfetch/config.jsonc;
  
  # Niri
  xdg.configFile."niri/config.kdl".source =
  ./dotfiles/niri/config.kdl;


  services.udiskie = {
    enable = true;
    tray = "never";
  };
}
