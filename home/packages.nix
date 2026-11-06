{ pkgs, ... }:

{
  home.packages = with pkgs; [
    mpv
    xwayland-satellite
    prismlauncher
    featherpad
    feh

    # Xilinx / FPGA
    xlsclients
    picocom

    # KDE and Dolphin
    kdePackages.dolphin
    kdePackages.ark
    kdePackages.gwenview
    kdePackages.okular
    kdePackages.qtsvg
    kdePackages.kio
    kdePackages.kio-fuse
    kdePackages.kio-extras

    # Development
    python3
    python3Packages.pip
    lua
    luarocks
    tree-sitter
    clang-tools
    lua-language-server
    pyright
    glslviewer
    zeal
    jdk

    # Office
    texliveFull
    libreoffice

    # Electrical / Electronic
    kicad
    qucs-s
    qucsator-rf
    nanovna-saver
    nanovna-qt
    freecad
  ];
}
