{ config, pkgs, lib, ... }:

{
  # Aggressive NVIDIA power management for suspend/resume
  # This completely powers off NVIDIA GPU before suspend
  
  systemd.services.nvidia-suspend-hook = {
    description = "Power off NVIDIA GPU before suspend";
    before = [ "systemd-suspend.service" ];
    wantedBy = [ "systemd-suspend.service" ];
    path = [ pkgs.systemd pkgs.kmod ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.writeScript "nvidia-suspend" ''
        #!/bin/sh
        set -e
        ${pkgs.systemd}/bin/logger "nvidia-suspend-hook: Starting NVIDIA suspend"
        
        # Stop display manager first
        ${pkgs.systemd}/bin/systemctl stop greetd || true
        
        # Remove NVIDIA modules in reverse dependency order
        ${pkgs.kmod}/bin/modprobe -r nvidia_uvm || true
        ${pkgs.kmod}/bin/modprobe -r nvidia_drm || true
        ${pkgs.kmod}/bin/modprobe -r nvidia_modeset || true
        sleep 1
        ${pkgs.kmod}/bin/modprobe -r nvidia || true
        
        # Power off GPU via ACPI if available
        if [ -e /sys/bus/pci/devices/0000:01:00.0/remove ]; then
          echo 1 > /sys/bus/pci/devices/0000:01:00.0/remove || true
        fi
        
        ${pkgs.systemd}/bin/logger "nvidia-suspend-hook: NVIDIA GPU powered off"
      ''}";
      ExecStop = "${pkgs.writeScript "nvidia-resume" ''
        #!/bin/sh
        set -e
        ${pkgs.systemd}/bin/logger "nvidia-suspend-hook: Resuming NVIDIA GPU"
        
        # Rescan PCI bus to detect GPU
        echo 1 > /sys/bus/pci/rescan || true
        
        # Reload NVIDIA modules
        ${pkgs.kmod}/bin/modprobe nvidia
        sleep 1
        ${pkgs.kmod}/bin/modprobe nvidia_modeset
        ${pkgs.kmod}/bin/modprobe nvidia_drm
        ${pkgs.kmod}/bin/modprobe nvidia_uvm
        
        # Reinitialize DRM
        sleep 2
        
        # Restart display manager
        ${pkgs.systemd}/bin/systemctl start greetd || true
        
        ${pkgs.systemd}/bin/logger "nvidia-suspend-hook: NVIDIA GPU resumed"
      ''}";
      RemainAfterExit = true;
    };
  };
}
