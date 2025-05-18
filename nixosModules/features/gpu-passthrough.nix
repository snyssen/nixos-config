{ pkgs, lib, config, ... }:
let cfg = config.myNixOS.gpu-passthrough;
in {
  options.myNixOS.gpu-passthrough = {
    platform = lib.mkOption {
      default = "intel";
      description = ''
        CPU platform (intel or amd)
      '';
    };
    user = lib.mkOption { default = "snyssen"; };
    vfioIds = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      description = ''
        List of VFIO IDs to isolate for GPU passthrough.
        See:
          - https://kilo.bytesize.xyz/gpu-passthrough-on-nixos
          - https://astrid.tech/2022/09/22/0/nixos-gpu-vfio/
      '';
    };
  };

  # Configure kernel options to make sure IOMMU & KVM support is on.
  boot = {
    kernelModules = [
      "kvm-${cfg.platform}"
      "vfio_virqfd"
      "vfio_pci"
      "vfio_iommu_type1"
      "vfio"
    ];
    kernelParams = [
      "${cfg.platform}_iommu=on"
      "${cfg.platform}_iommu=pt"
      "kvm.ignore_msrs=1"
    ];
    extraModprobeConfig =
      "options vfio-pci ids=${builtins.concatStringsSep "," cfg.vfioIds}";
  };

  # Add a file for looking-glass to use later. This will allow for viewing the guest VM's screen in a
  # performant way.
  systemd.tmpfiles.rules =
    [ "f /dev/shm/looking-glass 0660 ${cfg.user} qemu-libvirtd -" ];

  # Add virt-manager and looking-glass to use later.
  environment.systemPackages = with pkgs; [ virt-manager looking-glass-client ];

  # Enable virtualisation programs. These will be used by virt-manager to run your VM.
  virtualisation = {
    libvirtd = {
      enable = true;
      extraConfig = ''
        user="${cfg.user}"
      '';

      # Don't start any VMs automatically on boot.
      onBoot = "ignore";
      # Stop all running VMs on shutdown.
      onShutdown = "shutdown";

      qemu = {
        package = pkgs.qemu_kvm;
        ovmf.enable = true;
        verbatimConfig = ''
           namespaces = []
          user = "+${builtins.toString config.users.users.${cfg.user}.uid}"
        '';
      };
    };
  };

  users.users.${cfg.user}.extraGroups = [ "qemu-libvirtd" "libvirtd" "disk" ];
}
