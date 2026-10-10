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

    # Enable Noctalia
    programs.noctalia = { 
    enable = true;

      settings = { # This may also be a string or path to a .toml file.
        theme = {
          mode = "dark";
          source = "builtin";
          builtin = "Catppuccin";
        };

        wallpaper = {
          enabled = true;
          default.path = "~/Pictures/RosePine928887.png";
        };
    };
};
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
