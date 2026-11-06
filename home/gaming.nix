{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Emulators
    pcsx2
    rpcs3

    # Games
    openra
    endless-sky

    # Launchers
    prismlauncher
  ];
}
