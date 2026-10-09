
{ ... }:

{
  home.username = "apokaliph";
  home.homeDirectory = "/home/apokaliph";

  home.stateVersion = "26.05";

  services.udiskie = {
    enable = true;
    tray = "never";
  };
}
