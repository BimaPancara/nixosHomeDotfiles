{ config, pkgs, lib, ... }:

{
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Keep the latest 10 system generations in systemd-boot
  boot.loader.systemd-boot.configurationLimit = 10;

  # Kernel parameters for hybrid graphics and stability
  boot.kernelParams = [
    "processor.max_cstate=1"
    "efi_pstore.pstore_disable=1"
    "idle=nomove"
    "pcie_aspm=off"
    "iommu=pt"
    "nvidia-drm.modeset=1"
  ];

  # KVM support for AMD Ryzen CPU
  boot.kernelModules = [ "kvm-amd" ];
}
