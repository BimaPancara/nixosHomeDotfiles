{ config, pkgs, lib, ... }:

{
  networking.hostName = "Schicksal";

  # Enable networking
  networking.networkmanager.enable = true;

  # Firewall - allow essential services only
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [
    # 22  # SSH - uncomment if needed
  ];
  networking.firewall.allowedUDPPorts = [
    # Add UDP ports if needed
  ];
}
