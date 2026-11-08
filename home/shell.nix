{ pkgs, ... }:

{
  # Shell packages
  home.packages = with pkgs; [
    zsh
    starship
    git
  ];

  # Shell configuration
  xdg.configFile."starship.toml".source = ./shell/starship.toml;
  home.file.".zshrc".source = ./shell/.zshrc;

  # Nix-index for comma command
  programs.nix-index = {
    enable = true;
    enableZshIntegration = true;
  };
}
