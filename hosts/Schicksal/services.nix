{ config, pkgs, lib, ... }:

{
  # Xwayland
  programs.xwayland.enable = true;

  # Polkit authentication
  security.polkit.enable = true;

  # Zsh
  programs.zsh.enable = true;
  users.users.apokaliph.shell = pkgs.zsh;

  # Noctalia Greeter (display manager)
  services.displayManager.noctalia-greeter = {
    enable = true;
    # Configure power actions in the session panel
    # Changed suspend to hibernate due to NVIDIA S0/s2idle resume issues
    settings = {
      session = {
        power = {
          # Use hibernate instead of suspend (NVIDIA doesn't resume on S0 modern standby)
          suspend = "hibernate";
          # You can also disable suspend entirely:
          # suspend = "disabled";
        };
      };
    };
  };

  # Force wlroots to use AMD GPU only
  # Prevents NVIDIA CRTC crash causing kernel panic and graphical corruption
  systemd.services.greetd.serviceConfig.Environment = [
    "WLR_DRM_DEVICES=/dev/dri/card1"
    "WLR_NO_HARDWARE_CURSORS=1"
  ];

  # UDEV Rules for Digilent Basys 3 / FTDI JTAG
  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTR{idVendor}=="0403", ATTR{idProduct}=="6010", MODE="0660", GROUP="users"
  '';

  # Steam
  programs.steam.enable = true;

  # Niri window manager
  programs.niri.enable = true;

  # XDG Portal
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
      "org.freedesktop.impl.portal.FileChooser" = [ "kde" ];
    };
  };

  # Fonts
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    font-awesome
    noto-fonts
    noto-fonts-color-emoji
  ];

  fonts.fontconfig.enable = true;
}
