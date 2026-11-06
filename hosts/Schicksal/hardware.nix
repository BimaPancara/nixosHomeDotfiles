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

    # Power management enabled with TLP (finegrained for better battery)
    powerManagement.enable = true;
    powerManagement.finegrained = true;

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

  # Zram swap - prevents thrashing, better performance on low RAM
  zramSwap.enable = true;

  # TLP - Advanced power management for laptops (replaces power-profiles-daemon)
  services.tlp = {
    enable = true;
    settings = {
      # CPU power saving
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

      # PCIe ASPM (Active State Power Management)
      PCIE_ASPM_ON_AC = "performance";
      PCIE_ASPM_ON_BAT = "powersupersave";

      # Radeon graphics (AMD iGPU)
      RADEON_POWER_PROFILE_ON_AC = "high";
      RADEON_POWER_PROFILE_ON_BAT = "low";
      RADEON_DPM_STATE_ON_AC = "performance";
      RADEON_DPM_STATE_ON_BAT = "battery";

      # Runtime PM for PCIe devices
      RUNTIME_PM_ON_AC = "on";
      RUNTIME_PM_ON_BAT = "auto";

      # USB autosuspend
      USB_AUTOSUSPEND = 1;
      USB_BLACKLIST = "0403:6010"; # FTDI JTAG device

      # WiFi power saving
      WIFI_PWR_ON_AC = "off";
      WIFI_PWR_ON_BAT = "on";

      # Disk spindown (SSD - disabled)
      DISK_IDLE_SECS_ON_AC = 0;
      DISK_IDLE_SECS_ON_BAT = 0;

      # Sound power saving
      SOUND_POWER_SAVE_ON_AC = 0;
      SOUND_POWER_SAVE_ON_BAT = 1;
    };
  };

  # UPower still needed for battery monitoring
  services.upower.enable = true;
}
