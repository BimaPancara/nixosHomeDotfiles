{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Wine and Windows compatibility
    wineWow64Packages.stable    # Wine with WoW64 support (32-bit + 64-bit)
    winetricks                  # Helper script to install Windows libraries

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
