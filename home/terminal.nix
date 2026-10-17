{ pkgs, ... }:


{

# Add Packages
    home.packages = with pkgs; [
	fastfetch
        neovim
        yazi
        termusic
        tree
	youtube-tui
	yt-dlp
	btop
	lazygit
	unzip

];

  xdg.configFile = {
    # Fastfetch
    "fastfetch/config.jsonc".source =
      ./dotfiles/fastfetch/config.jsonc;

    # Neovim
    "nvim".source =
      ./dotfiles/nvim;

    # Yazi
    "yazi".source =
      ./dotfiles/yazi;

    # Termusic
    "termusic/tui.toml".source =
      ./dotfiles/termusic/tui.toml;

    "termusic/themes".source =
      ./dotfiles/termusic/themes;

    # YouTube TUI
    "youtube-tui".source =
      ./dotfiles/youtube-tui;
  };
}
