{ config, pkgs, lib, ... }:

{
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Keep the latest 20 system generations in systemd-boot
  boot.loader.systemd-boot.configurationLimit = 20;

  # Kernel parameters for hybrid graphics and stability
  # AMD iGPU + NVIDIA RTX 3050 Mobile offload configuration
  boot.kernelParams = [
    # CPU power management
    "processor.max_cstate=1"
    "idle=nomove"
    "pcie_aspm=off"

    # IOMMU for GPU passthrough
    "iommu=pt"

    # EFI crash logging
    "efi_pstore.pstore_disable=1"

    # NVIDIA DRM modesetting (required for Wayland)
    "nvidia-drm.modeset=1"

    # NVIDIA framebuffer device (prevents graphical corruption)
    "nvidia-drm.fbdev=1"

    # Enable NVIDIA DRM KMS client (helps with resume)
    "nvidia-drm.modeset=1"

    # NVIDIA backlight and memory preservation
    "nvidia.NVreg_EnableBacklight=1"
    "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
    "nvidia.NVreg_TemporaryFilePath=/var/tmp"

    # Disable NVIDIA power management (causes instability on laptops)
    "NVreg_DynamicPowerManagement=0"

    # ACPI OS layer - tells BIOS we're handling power management
    "acpi_osi=Linux"
  ];

  # KVM support for AMD Ryzen CPU
  boot.kernelModules = [ "kvm-amd" ];
}
