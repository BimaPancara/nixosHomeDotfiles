
{ pkgs, ... }:

{
# Add Packages
    home.packages = with pkgs; [
    # Emulator
    pcsx2
    rpcs3

    # Games
    openra
    endless-sky
	];
}
