
{ pkgs, ... }:

{
    home.username = "apokaliph";
    home.homeDirectory = "/home/apokaliph";

    home.stateVersion = "26.05";

    home.sessionVariables = {
	XDG_CURRENT_DESKTOP = "niri";
    };

# Add Packages
    home.packages = with pkgs; [
	fastfetch
        waybar
        swaybg
	swaylock
        fuzzel
        foot
        zsh
        starship
        neovim
        yazi
        termusic
        tree
        mpv
	youtube-tui
	yt-dlp
	btop
	xwayland-satellite
	lazygit

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
    ];

# Link Config
# Fastfetch
    xdg.configFile."fastfetch/config.jsonc".source =
	./dotfiles/fastfetch/config.jsonc;

# Niri
    xdg.configFile."niri/config.kdl".source =
	./dotfiles/niri/config.kdl;

# Waybar
    xdg.configFile."waybar".source = ./dotfiles/waybar;

# Fuzzel
    xdg.configFile."fuzzel".source = ./dotfiles/fuzzel;

# Foot
    xdg.configFile."foot".source = ./dotfiles/foot;

# Starship
    xdg.configFile."starship.toml".source =
	./shell/starship.toml;

# Zsh
    home.file.".zshrc".source =
	./shell/.zshrc;

# Neovim
    xdg.configFile."nvim".source = ./dotfiles/nvim;

# Yazi
    xdg.configFile."yazi".source =
	./dotfiles/yazi; 

# Termusic
    xdg.configFile."termusic/tui.toml".source =
	./dotfiles/termusic/tui.toml;
    xdg.configFile."termusic/themes".source =
	./dotfiles/termusic/themes;

# YouTube TUI
    xdg.configFile."youtube-tui".source =
	./dotfiles/youtube-tui;

services.udiskie = {
	enable = true;
	tray = "never";
    };
}
