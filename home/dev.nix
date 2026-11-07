{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Python
    python3
    python3Packages.pip

    # Lua
    lua
    luarocks
    lua-language-server

    # C/C++
    clang-tools
    pyright

    # Tree-sitter
    tree-sitter

    # Java
    jdk

    # Documentation
    zeal

    # Electrical / Electronic
    kicad
    qucs-s
    qucsator-rf
    nanovna-saver
    nanovna-qt
    freecad

    # Xilinx / FPGA
    xlsclients
    picocom
  ];
}
