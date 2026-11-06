{ pkgs, ... }:

{
  home.packages = with pkgs; [
    niri
    waybar
    foot
    fuzzel
    firefox
  ];

  # Enable Noctalia
  programs.noctalia = {
    enable = true;
    settings = {
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

  # Desktop configuration
  xdg.configFile = {
    "niri/config.kdl".source = ./dotfiles/niri/config.kdl;
    "waybar".source = ./dotfiles/waybar;
    "foot".source = ./dotfiles/foot;
  };
}
