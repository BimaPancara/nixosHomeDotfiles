{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Window manager satellite
    xwayland-satellite

    # Text editor
    featherpad
  ];
}
