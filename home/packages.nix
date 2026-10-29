
{ pkgs, ... }:

{
# Add Packages
    home.packages = with pkgs; [
        mpv
	xwayland-satellite
	prismlauncher
	featherpad
	feh

    # Xilinx Stuff
	xlsclients
	picocom

    # KDE and Dolphin Stuff
	kdePackages.dolphin
        kdePackages.ark
	kdePackages.gwenview
	kdePackages.okular
	kdePackages.qtsvg
	kdePackages.kio
	kdePackages.kio-fuse
	kdePackages.kio-extras

    # Script, Coding, etc
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

    # Office Writing
	texliveFull
	libreoffice

    # Electrical and Electronic
	kicad
	qucs-s
	qucsator-rf
	nanovna-saver
	nanovna-qt
	freecad


	];
}
