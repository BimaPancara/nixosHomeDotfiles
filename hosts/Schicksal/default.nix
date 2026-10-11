{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../modules/nixos/storage.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = [
  "efi_pstore.pstore_disable=1"
  "idle=nomwait"
  "pcie_aspm=off"
  ];

  # Keep the latest 10 system generations in systemd-boot
  boot.loader.systemd-boot.configurationLimit = 10;

  # Automatically clean up old generations and unused store paths
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  networking.hostName = "Schicksal"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.


  # Enable networking
  networking.networkmanager.enable = true;
  #-----
  #Noctalia Shell
  # Enable Bluetooth
  hardware.bluetooth.enable = true;
  
  # Enable Power Daemon Profile
  services.power-profiles-daemon.enable = true;
  
  # Enable UPower for Battery Report 
  services.upower.enable = true;
  #-----
  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."apokaliph" = {
    isNormalUser = true;
    description = "apokaliph";
    extraGroups = [ "networkmanager" "wheel" "dialout" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
 
 # Setup Automount
 fileSystems."/mnt/data" = {
  device = "/dev/disk/by-uuid/aabcd0c5-4d2b-4b91-b5fe-d92cd765a6b7";
  fsType = "ext4";
  options = [
    "nofail"
    "x-systemd.automount"
    "x-systemd.device-timeout=5s"
  ];
};
  
  # Xwayland
  programs.xwayland.enable = true;
  
  # Zsh
  programs.zsh.enable = true;
  users.users.apokaliph.shell = pkgs.zsh;

  # Noctalia Greeter
  services.displayManager.noctalia-greeter = {
    enable = true;
  };

# List packages installed in system profile.
# You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
      neovim
      wget
      foot
      fuzzel
      firefox
      git
      adwaita-icon-theme
      brightnessctl
      playerctl

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
      wget
      bind           # dig, nslookup
      traceroute
      tcpdump

# Disk and filesystem management
      parted
      gptfdisk       # gdisk, sgdisk
      dosfstools    # mkfs.fat, fsck.fat
      e2fsprogs      # ext2/3/4 tools
      btrfs-progs    # Btrfs utilities
      ncdu

# Useful modern CLI tools
      ripgrep        # rg
      fd             # fd
      jq             # JSON processing
      tmux
      ];

  # Install List of Fonts
  fonts.packages = with pkgs; [
  # Main programming font with terminal icons
  nerd-fonts.jetbrains-mono

  # Icons for Waybar and other applications
  font-awesome

  # General text and Unicode coverage
  noto-fonts
  noto-fonts-color-emoji
];

  fonts.fontconfig.enable = true;

  # Enable steam
  programs.steam.enable = true;

  # Enable niri window manager
  programs.niri.enable = true;

  # Experimental features of NixOs
  nix.settings.experimental-features = [
  "nix-command"
  "flakes"
  ];
  
  # Add .backup when encounter duplicate file
  home-manager.backupFileExtension = "backup";

  # xdg Portal
  xdg.portal = {
    enable = true;

    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      kdePackages.xdg-desktop-portal-kde
      xdg-desktop-portal-gnome
    ];

    config.niri = {
	default = lib.mkForce [ "kde" "gtk" ];
      
      "org.freedesktop.impl.portal.ScreenCast" = "gnome";
      "org.freedesktop.impl.portal.FileChooser" = [
        "kde"
      ];
    };
  };

   # UDEV Rules
   services.udev.extraRules = ''
   # Digilent Basys 3 / FTDI JTAG interface
   SUBSYSTEM=="usb", ATTR{idVendor}=="0403", ATTR{idProduct}=="6010", MODE="0660", GROUP="users"
   '';

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "26.05"; # Did you read the comment?

}
