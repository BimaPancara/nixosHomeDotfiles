{ config, pkgs, lib, ... }:

{
  # Keep more boot generations for safety
  boot.loader.systemd-boot.configurationLimit = 20;

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
    smartmontools      # SMART disk health
    memtest86plus      # Memory testing (added to boot menu)
  ];

  # Add memtest to boot menu
  boot.loader.systemd-boot.extraEntries = {
    "memtest.conf" = ''
      title MemTest86+
      efi /memtest.efi
    '';
  };

  # NVIDIA stability parameters (merged with boot.nix params)
  boot.kernelParams = [
    "nvidia.NVreg_EnableBacklight=1"
    "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
    "nvidia.NVreg_TemporaryFilePath=/var/tmp"
  ];

  # Hardware error logging
  boot.extraModprobeConfig = ''
    # Enable NVIDIA debugging
    options nvidia NVreg_ResmanDebugLevel=0
    options nvidia NVreg_RmLogonRC=1
  '';
}
