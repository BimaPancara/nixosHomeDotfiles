{ config, pkgs, lib, ... }:

{
  # Disable powertop to avoid conflicts with TLP
  powerManagement.powertop.enable = false;

  # Enable core dumps for debugging crashes
  systemd.coredump.enable = true;
  systemd.coredump.settings = {
    Coredump = {
      ProcessSizeMax = "2G";
      ExternalSizeMax = "2G";
    };
  };

  # Early OOM killer - prevents system freeze before OOM
  services.earlyoom = {
    enable = true;
    freeMemThreshold = 5;
    freeSwapThreshold = 10;
  };

  # SMART disk monitoring - alerts before disk failure
  services.smartd = {
    enable = true;
    # Use default autodetection with simple config
    extraOptions = [ "-i" "1800" ];  # Check every 30 minutes
  };

  # Thermal monitoring
  services.thermald.enable = true;

  # Crash debugging tools
  environment.systemPackages = with pkgs; [
    sysstat            # Performance monitoring (sar, iostat)
    powertop           # Power consumption analysis
    lm_sensors         # Temperature monitoring
    memtest86plus      # Memory testing (added to boot menu)
  ];

  # Add memtest to boot menu
  boot.loader.systemd-boot.extraEntries = {
    "memtest.conf" = ''
      title MemTest86+
      efi /memtest.efi
    '';
  };

  # Hardware error logging
  boot.extraModprobeConfig = ''
    # Enable NVIDIA debugging
    options nvidia NVreg_ResmanDebugLevel=0
    options nvidia NVreg_RmLogonRC=1
  '';

  # Fix NVIDIA suspend/resume - explicitly enable systemd services
  # NixOS preset ignores all units, so we must explicitly enable these
  systemd.services.nvidia-suspend.enable = lib.mkForce true;
  systemd.services.nvidia-resume.enable = lib.mkForce true;
  systemd.services.nvidia-hibernate.enable = lib.mkForce true;

  # Fix systemd 256+ suspend freeze timeout with NVIDIA/compositors
  # Prevents "Failed to freeze unit 'user.slice': Connection timed out"
  systemd.services.systemd-suspend.environment.SYSTEMD_SLEEP_FREEZE_USER_SESSIONS = "false";
  systemd.services.systemd-hibernate.environment.SYSTEMD_SLEEP_FREEZE_USER_SESSIONS = "false";

  # Force NVIDIA services to run despite preset: ignore *
  # This is critical - without this, NVIDIA resume never runs
  systemd.user.services.nvidia-suspend.enable = lib.mkForce true;
  systemd.user.services.nvidia-resume.enable = lib.mkForce true;
  systemd.services.nvidia-suspend.unitConfig.IgnoreOnIsolate = false;
  systemd.services.nvidia-resume.unitConfig.IgnoreOnIsolate = false;
}
