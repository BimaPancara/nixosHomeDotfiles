# NixOS Configuration - Schicksal

Personal NixOS configuration for host **Schicksal** (laptop with hybrid AMD+NVIDIA graphics).

## Hardware

- **GPU**: AMD Ryzen 7 6000 Series iGPU + NVIDIA RTX 3050 Mobile (hybrid graphics)
- **CPU**: AMD Ryzen (KVM enabled)
- **Boot**: systemd-boot (UEFI)
- **Display Manager**: noctalia-greeter (greetd)
- **Window Manager**: Niri (Wayland)

## Quick Start

### Build and Switch

```bash
sudo nixos-rebuild switch --flake .#Schicksal
```

### Build (without switching)

```bash
nixos-rebuild build --flake .#Schicksal
```

### Boot into specific generation

```bash
sudo nixos-rebuild boot --flake .#Schicksal
```

## Development

### Format Nix files

```bash
nix fmt
```

### Enter development shell

```bash
nix develop
```

Provides: `nil` (language server), `nixfmt` (formatter), `statix` (linter)

### Check configuration

```bash
nix flake check
```

## Structure

```
.
├── flake.nix                    # Flake entry point, inputs, outputs
├── README.md                    # This file
│
├── hosts/
│   └── Schicksal/
│       ├── default.nix          # Main host entry (imports only)
│       ├── hardware-configuration.nix  # Auto-generated, do not modify
│       ├── boot.nix             # Bootloader, kernel params, KVM
│       ├── hardware.nix         # Hybrid GPU, Bluetooth, power
│       ├── networking.nix       # Hostname, NetworkManager
│       ├── locale.nix           # Timezone, locale, keymap
│       ├── users.nix            # Users, groups, sudo
│       ├── services.nix         # Display manager, portals, fonts
│       ├── virtualisation.nix   # libvirt, virt-manager, spice
│       ├── system-packages.nix  # System-wide tools
│       ├── nix.nix              # GC, flakes, home-manager settings
│       └── storage.nix          # Automount configuration
│
├── home/
│   ├── apokaliph.nix            # Home Manager entry
│   ├── packages.nix             # User packages (KDE, dev tools, etc.)
│   ├── desktop.nix              # Niri, Waybar, foot, Noctalia
│   ├── terminal.nix             # neovim, yazi, btop, lazygit
│   ├── shell.nix                # zsh, starship
│   ├── services.nix             # udiskie, ssh-agent
│   ├── game.nix                 # emulators, games
│   └── emacs.nix                # Emacs configuration
│
├── modules/
│   └── nixos/
│       ├── storage.nix          # udisks2 module
│       └── podman.nix           # Podman container runtime
│
└── dotfiles/                    # Configuration files for various tools
    ├── niri/
    ├── waybar/
    ├── foot/
    ├── nvim/
    ├── yazi/
    └── ...
```

## Key Features

### Hybrid Graphics

NVIDIA offload with AMD as primary display adapter:

```bash
# Run application on NVIDIA GPU
nvidia-offload <application>
```

### Virtualisation

- **libvirt + QEMU**: Full VM support with virt-manager GUI
- **Podman**: Rootless containers
- **SPICE USB redirection**: USB passthrough to VMs

### Desktop Environment

- **Niri**: Scrollable Wayland compositor
- **Waybar**: Status bar
- **Foot**: Wayland terminal
- **Noctalia**: Theme and wallpaper management (Catppuccin)

### User Tools

| Category | Tools |
|----------|-------|
| Terminal | neovim, yazi, btop, lazygit, tmux |
| Development | Python, Lua, JDK, KiCad, FreeCAD |
| KDE | Dolphin, Ark, Gwenview, Okular |
| Multimedia | mpv, feh |
| Gaming | Steam, PCSX2, RPCS3, OpenRA |

## Maintenance

### Garbage Collection

Automatic weekly GC removes generations older than 30 days.

Manual cleanup:

```bash
nix-collect-garbage --delete-older-than 30d
```

### Update flake inputs

```bash
nix flake update
```

### Rollback to previous generation

Hold `Shift` during boot to access systemd-boot menu, or:

```bash
sudo nixos-rebuild switch --rollback
```

## Troubleshooting

### Kernel panic on boot

This configuration includes workarounds for known hybrid graphics issues:

- `WLR_DRM_DEVICES=/dev/dri/card1` - Force AMD GPU for display
- `WLR_NO_HARDWARE_CURSORS=1` - Disable hardware cursors
- Conservative NVIDIA power management (disabled)

### Build fails after hardware change

Regenerate hardware configuration:

```bash
sudo nixos-generate-config --show-hardware-config > hosts/Schicksal/hardware-configuration.nix
```

## License

MIT

---

## Stability & Debugging

### Kernel Panic Recovery

1. **Hold Shift** during boot to access systemd-boot menu
2. Select a previous generation (up to 20 kept)
3. Boot into working system
4. Investigate logs: `journalctl -b -1 -p err`

### Debugging Tools

```bash
# View hardware errors
journalctl -k -p err

# Check SMART disk health
sudo smartctl -a /dev/nvme0n1

# Monitor temperatures
sensors

# Analyze crashes
crash /var/lib/systemd/coredump/*

# Memory test
# Select "MemTest86+" from boot menu
```

### NVIDIA Stability

If you experience kernel panics or graphical corruption:

1. Boot with `nomodeset` kernel parameter
2. Check NVIDIA logs: `journalctl -u nvidia-persistenced`
3. Try disabling power management in `hosts/Schicksal/hardware.nix`

### Early OOM

System will kill processes before freezing:
- Memory threshold: 5%
- Swap threshold: 10%

Check logs: `journalctl -u earlyoom`
