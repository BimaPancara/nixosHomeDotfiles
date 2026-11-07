{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    virtiofsd

    # Nix helper - nicer interface for nixos-rebuild
    nh               # nix helper (nh os switch, nh clean all, etc.)
    nix-index        # provides comma: search and install packages quickly

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
    unzip
    p7zip
    unrar
    which
    file
    tree
    git            # Version control (system-wide)

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

    # Recovery tools - for when the system is in a bad state
    bash           # Recovery shell (more compatible than zsh)
    gdb            # Debugging crashes
    inetutils      # Basic network tools
    iotop          # I/O monitoring
    iw             # Wireless configuration
    lynx           # Text browser for offline docs
    man-pages      # Local documentation
    openssl        # Encryption/certificates
    pv             # Progress indicator for pipes
    screen         # Terminal multiplexer
    sg3_utils      # SCSI/low-level disk tools
    socat          # Network relay/debugging
    units          # Unit conversion
    unixtools.route  # Routing table
    vim            # Editor for recovery
    wget           # Download without network deps
    wirelesstools  # Legacy wireless tools
  ];
}
