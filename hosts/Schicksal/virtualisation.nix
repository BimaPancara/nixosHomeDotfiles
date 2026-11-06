{ config, pkgs, lib, ... }:

{
  # Libvirt for VMs
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
      vhostUserPackages = [ pkgs.virtiofsd ];
    };
  };

  programs.virt-manager.enable = true;

  # USB device redirection into VMs
  virtualisation.spiceUSBRedirection.enable = true;

  # Define and start libvirt default network
  systemd.services.libvirt-default-network = {
    description = "Define and start libvirt default network";
    after = [ "libvirtd.service" ];
    requires = [ "libvirtd.service" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      Environment = [ "PATH=${pkgs.libvirt}/bin:${pkgs.coreutils}/bin" ];
    };
    script = ''
      if ! ${pkgs.libvirt}/bin/virsh net-info default &>/dev/null; then
        ${pkgs.libvirt}/bin/virsh net-define ${pkgs.writeText "default-network.xml" ''
          <network>
            <name>default</name>
            <forward mode='nat'/>
            <bridge name='virbr0' stp='on' delay='0'/>
            <ip address='192.168.122.1' netmask='255.255.255.0'>
              <dhcp>
                <range start='192.168.122.2' end='192.168.122.254'/>
              </dhcp>
            </ip>
          </network>
        ''}
      fi
      ${pkgs.libvirt}/bin/virsh net-start default || true
      ${pkgs.libvirt}/bin/virsh net-autostart default || true
    '';
  };
}
