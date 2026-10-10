{ pkgs, ... }:

{


# Add Packages
    home.packages = with pkgs; [
	zsh
        starship
    ];


# Shell configuration
  xdg.configFile."starship.toml".source =
    ./shell/starship.toml;

  home.file.".zshrc".source =
    ./shell/.zshrc;
}
