{ config, pkgs, lib, ... }:

{
  # Sleep hook to handle suspend/resume properly with hybrid graphics
  # This runs before suspend and after resume to ensure clean state
  systemd.services.sleep-hook = {
    description = "System sleep hook for hybrid graphics";
    before = [ "sleep.target" ];
    after = [ "nvidia-suspend.service" ];
    wantedBy = [ "sleep.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.writeScript "sleep-hook-start" ''
        #!/bin/sh
        logger "sleep-hook: Preparing for suspend"
        # Stop display manager to release GPU resources
        systemctl stop greetd || true
        # Unload NVIDIA DRM module to prevent resume hang
        modprobe -r nvidia_drm || true
        modprobe -r nvidia_modeset || true
      ''}";
      ExecStop = "${pkgs.writeScript "sleep-hook-stop" ''
        #!/bin/sh
        logger "sleep-hook: Resuming from suspend"
        # Reload NVIDIA DRM module
        modprobe nvidia_drm
        modprobe nvidia_modeset
        # Wait for GPU to initialize
        sleep 2
        # Restart display manager
        systemctl start greetd || true
      ''}";
      RemainAfterExit = true;
    };
  };
}
