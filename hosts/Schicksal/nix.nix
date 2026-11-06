{ config, pkgs, lib, ... }:

{
  # Automatic garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  # Experimental features
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Home Manager integration
  home-manager.backupFileExtension = "backup";

  # System state version
  system.stateVersion = "26.05";
}
