{ config, pkgs, lib, ... }:

{
  # NVIDIA RTX 3050 + AMD iGPU hybrid graphics
  hardware.graphics.enable = true;

  services.xserver.videoDrivers = [
    "amdgpu"
    "nvidia"
  ];

  hardware.nvidia = {
    open = false;
    modesetting.enable = true;

    # Conservative power management (prevents instability)
    powerManagement.enable = false;
    powerManagement.finegrained = false;

    prime = {
      amdgpuBusId = "PCI:6@0:0:0";
      nvidiaBusId = "PCI:1@0:0:0";

      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
    };
  };

  # Bluetooth
  hardware.bluetooth.enable = true;

  # Power management
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;
}
