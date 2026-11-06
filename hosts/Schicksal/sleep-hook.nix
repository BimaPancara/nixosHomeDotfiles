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
        # Before suspend: log current state
        logger "sleep-hook: Preparing for suspend"
        # Stop greetd to release GPU resources
        systemctl stop greetd
      ''}";
      ExecStop = "${pkgs.writeScript "sleep-hook-stop" ''
        #!/bin/sh
        # After resume: restart display manager
        logger "sleep-hook: Resuming from suspend"
        # Give NVIDIA resume service time to complete
        sleep 2
        # Restart greetd
        systemctl start greetd
      ''}";
      RemainAfterExit = true;
    };
  };
}
