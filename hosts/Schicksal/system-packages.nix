{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    virtiofsd

    # Hardware inspection
    usbutils       # lsusb
    pciutils       # lspci
    dmidecode      # BIOS, motherboard and DMI information
    efibootmgr     # UEFI boot entries
    smartmontools  # SMART disk health
    lm_sensors     # sensors: CPU/GPU temperature readings

    # Essential system utilities
    util-linux     # lsblk, lscpu, lsns, mount, dmesg
    coreutils      # ls, cp, mv, rm, df, du, etc.
    findutils      # find, xargs
    gawk           # awk
    gnugrep        # grep
    gnused         # sed
    gnutar         # tar
    gzip
    bzip2
    xz
    which
    file
    tree

    # Process and performance monitoring
    procps         # ps, top, free, uptime
    psmisc         # killall, fuser
    lsof

    # Networking
    iproute2       # ip, ss
    iputils        # ping, tracepath
    ethtool
    curl
    bind           # dig, nslookup
    traceroute
    tcpdump

    # Disk and filesystem management
    parted
    gptfdisk       # gdisk, sgdisk
    dosfstools     # mkfs.fat, fsck.fat
    e2fsprogs      # ext2/3/4 tools
    btrfs-progs    # Btrfs utilities
    ncdu

    # Useful modern CLI tools
    ripgrep        # rg
    fd             # fd
    jq             # JSON processing
  ];
}
