{ config, pkgs, lib, ... }:

{
  networking.hostName = "Schicksal";

  # Enable networking
  networking.networkmanager.enable = true;
}
