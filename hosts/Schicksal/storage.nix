{ config, pkgs, lib, ... }:

{
  # Automount for /mnt/data
  fileSystems."/mnt/data" = {
    device = "/dev/disk/by-uuid/aabcd0c5-4d2b-4b91-b5fe-d92cd765a6b7";
    fsType = "ext4";
    options = [
      "nofail"
      "x-systemd.automount"
      "x-systemd.device-timeout=5s"
    ];
  };
}
