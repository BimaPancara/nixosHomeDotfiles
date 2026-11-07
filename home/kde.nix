{ pkgs, ... }:

let
  kde = pkgs.kdePackages;
in
{
  home.packages = with pkgs; [
    # File manager
    kde.dolphin

    # Archive manager
    kde.ark

    # Image viewer
    kde.gwenview

    # PDF viewer
    kde.okular

    # KDE integration
    kde.qtsvg
    kde.kio
    kde.kio-fuse
    kde.kio-extras
  ];
}
