{ config, pkgs, lib, ... }:

{
  # Sleep hook to handle suspend/resume properly with hybrid graphics
  # This runs before suspend and after resume to ensure clean state
  systemd.services.sleep-hook = {
    description = "System sleep hook for hybrid graphics";
    before = [ "sleep.target" ];
    after = [ "nvidia-suspend.service" ];
    wantedBy = [ "sleep.target" ];
    path = [ pkgs.systemd pkgs.kmod ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.writeScript "sleep-hook-start" ''
        #!/bin/sh
        ${pkgs.systemd}/bin/logger "sleep-hook: Preparing for suspend"
        # Stop display manager to release GPU resources
        ${pkgs.systemd}/bin/systemctl stop greetd || true
        # Unload NVIDIA DRM module to prevent resume hang
        ${pkgs.kmod}/bin/modprobe -r nvidia_drm || true
        ${pkgs.kmod}/bin/modprobe -r nvidia_modeset || true
      ''}";
      ExecStop = "${pkgs.writeScript "sleep-hook-stop" ''
        #!/bin/sh
        ${pkgs.systemd}/bin/logger "sleep-hook: Resuming from suspend"
        # Reload NVIDIA DRM module
        ${pkgs.kmod}/bin/modprobe nvidia_drm
        ${pkgs.kmod}/bin/modprobe nvidia_modeset
        # Wait for GPU to initialize
        sleep 2
        # Restart display manager
        ${pkgs.systemd}/bin/systemctl start greetd || true
      ''}";
      RemainAfterExit = true;
    };
  };
}
