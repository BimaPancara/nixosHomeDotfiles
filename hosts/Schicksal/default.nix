{ config, pkgs, lib, ... }:

{
  imports = [
    # Hardware configuration (auto-generated, do not modify)
    ./hardware-configuration.nix

    # Modular configuration files
    ./boot.nix
    ./hardware.nix
    ./networking.nix
    ./locale.nix
    ./users.nix
    ./services.nix
    ./virtualisation.nix
    ./system-packages.nix
    ./nix.nix
    ./storage.nix

    # Stability and debugging
    ./stability.nix
    ./sleep-hook.nix
    ./suspend.nix

    # NixOS modules
    ../../modules/nixos/storage.nix
    ../../modules/nixos/podman.nix
  ];
}
