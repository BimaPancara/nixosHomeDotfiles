
{ pkgs, ... }:

{
    home.username = "apokaliph";
    home.homeDirectory = "/home/apokaliph";

    home.stateVersion = "26.05";

    home.sessionVariables = {
	XDG_CURRENT_DESKTOP = "niri";
    };


    imports =[
	./packages.nix
	./desktop.nix
	./shell.nix
	./services.nix
	./terminal.nix
	./game.nix
	./emacs.nix
    ];

}
