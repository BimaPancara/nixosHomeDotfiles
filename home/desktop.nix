{ pkgs, ... }:

{

# Desktop Packages
    home.packages = with pkgs; [
	niri
        waybar
        fuzzel
        foot
        swaybg
        swaylock
    ];

# Desktop Configuration
    xdg.configFile = {
	"niri/config.kdl".source =
	    ./dotfiles/niri/config.kdl;

	"waybar".source =
	    ./dotfiles/waybar;

	"fuzzel".source =
	    ./dotfiles/fuzzel;

	"foot".source =
	    ./dotfiles/foot;
    };

}
