{ config, pkgs, lib, ... }:

{
  users.users."apokaliph" = {
    isNormalUser = true;
    description = "apokaliph";
    extraGroups = [ "networkmanager" "wheel" "dialout" "libvirtd" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
}
