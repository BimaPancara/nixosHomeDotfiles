{ config, pkgs, lib, ... }:

{
  users.users."apokaliph" = {
    isNormalUser = true;
    description = "apokaliph";
    extraGroups = [ "networkmanager" "wheel" "dialout" "libvirtd" ];
    packages = with pkgs; [];
  };

  # Sudo configuration
  security.sudo = {
    enable = true;
    wheelNeedsPassword = true;  # Require password for sudo
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
}
