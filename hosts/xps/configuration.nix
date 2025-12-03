{
  config,
  pkgs,
  lib,
  inputs,
  outputs,
  system,
  myLib,
  hm,
  ...
}:
let
  syncthingData = import ../../data/syncthing.nix;
in
{

  #
  ## WORKAROUNDS
  #

  # https://github.com/NixOS/nixpkgs/issues/353990
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.beta;

  #########################

  imports = [
    inputs.disko.nixosModules.disko
    ./disk-config.nix
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.dell-xps-15-7590-nvidia
    inputs.stylix.nixosModules.stylix
  ];

  specialisation = {
    cosmic.configuration = {
      myNixOS.bundles = {
        gnome.enable = false;
        cosmic.enable = true;
      };
    };
  };

  myNixOS = {
    user = {
      enable = true;
      home-manager = {
        enable = true;
        config = ./home.nix;
      };
      zsh.enable = true;
    };

    bundles = {
      gnome.enable = lib.mkDefault true;
      gaming.enable = true;
    };

    grub = {
      enable = true;
      timeout = 5;
    };
    syncthing = {
      enable = true;
      username = "snyssen";
      devices = syncthingData.devices;
      folders = {
        PrismLauncher = {
          path = "/home/snyssen/.local/share/PrismLauncher";
          devices = [
            "sync.snyssen.be"
            "gaming"
          ];
        };
        RetroArch = {
          path = "/home/snyssen/.config/retroarch";
          devices = [
            "sync.snyssen.be"
            "gaming"
          ];
        };
        Notes = {
          path = "/home/snyssen/Notes";
          devices = [
            "sync.snyssen.be"
            "gaming"
            "Pixel 8 Pro"
            "sninful"
          ];
        };
      };
    };

    docker.enable = true;
    logitech.enable = true;
    printing.enable = true;
    node-exporter.enable = true;
    tailscale.enable = true;
  };

  stylix = {
    enable = true;
    image = ../../files/wallpapers/bear1.jpg;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/atelier-forest.yaml";
    polarity = "dark";

    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.fira-mono;
        name = "FiraMono Nerd Font Mono";
      };
    };
  };

  environment = {
    systemPackages = with pkgs; [
      qemu
      quickemu
      # quickgui
    ];
  };

  virtualisation.vmVariant = {
    # following configuration is added only when building VM with build-vm
    virtualisation = {
      memorySize = 2048; # Use 2048MiB memory.
      cores = 3;
      # graphics = true;
    };
  };

  # Temporary workaround for accessing server from tailscale
  # networking.hosts = {
  #   "100.114.242.89" = ["snyssen.be" "dash.snyssen.be" "monitor.snyssen.be"];
  # };

  system.name = "xps";
  system.stateVersion = "23.05";
}
