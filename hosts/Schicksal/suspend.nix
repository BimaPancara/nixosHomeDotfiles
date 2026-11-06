{ config, pkgs, lib, ... }:

{
  # Aggressive NVIDIA power management for suspend/resume
  # This completely powers off NVIDIA GPU before suspend
  
  systemd.services.nvidia-suspend-hook = {
    description = "Power off NVIDIA GPU before suspend";
    before = [ "systemd-suspend.service" ];
    wantedBy = [ "systemd-suspend.service" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.writeScript "nvidia-suspend" ''
        #!/bin/sh
        set -e
        logger "nvidia-suspend-hook: Starting NVIDIA suspend"
        
        # Stop display manager first
        systemctl stop greetd || true
        
        # Remove NVIDIA modules in reverse dependency order
        modprobe -r nvidia_uvm || true
        modprobe -r nvidia_drm || true
        modprobe -r nvidia_modeset || true
        sleep 1
        modprobe -r nvidia || true
        
        # Power off GPU via ACPI if available
        if [ -e /sys/bus/pci/devices/0000:01:00.0/remove ]; then
          echo 1 > /sys/bus/pci/devices/0000:01:00.0/remove || true
        fi
        
        logger "nvidia-suspend-hook: NVIDIA GPU powered off"
      ''}";
      ExecStop = "${pkgs.writeScript "nvidia-resume" ''
        #!/bin/sh
        set -e
        logger "nvidia-suspend-hook: Resuming NVIDIA GPU"
        
        # Rescan PCI bus to detect GPU
        echo 1 > /sys/bus/pci/rescan || true
        
        # Reload NVIDIA modules
        modprobe nvidia
        sleep 1
        modprobe nvidia_modeset
        modprobe nvidia_drm
        modprobe nvidia_uvm
        
        # Reinitialize DRM
        sleep 2
        
        # Restart display manager
        systemctl start greetd || true
        
        logger "nvidia-suspend-hook: NVIDIA GPU resumed"
      ''}";
      RemainAfterExit = true;
    };
  };
}
