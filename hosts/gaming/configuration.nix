{ config, pkgs, lib, inputs, outputs, system, myLib, hm, ... }:
let syncthingData = import ../../data/syncthing.nix;
in {
  imports = [
    ./hardware-configuration.nix
    inputs.disko.nixosModules.disko
    inputs.stylix.nixosModules.stylix
    ./disk-config.nix
    { disko.devices.disk.disk1.device = "/dev/nvme1n1"; }
  ];

  # TODO: disable, this is only for testing
  services.openssh.enable = true;
  users.users.snyssen.openssh.authorizedKeys.keys = [
    # change this to your ssh key
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCmidzOIAxpxW9nEFu+z6vW2ya2aH3CFIq8npZzJ/QZBVVHNb/gRQsT/ISluV3n/c7fg+4ZgUnkUUHIg/jgcpXqlYFzNnefXgoNyUJIMzOqyAYvxBcCx0Yye/KYwJ/MvLci8gSdWuYCh7Xnzp2WGAiNJD9MOWled/gsFwI/FDbI0w56/2UUEXFHmh0xbtnK4t806A6L+8e43Z9rLMO2EHE35rbm03HJZMHRluFzvr0HaNueKkkDQGJj27w1Tbhqr3w08GeXbj4FFCWQ40Te9cvaSLDacVk12LkCKUNSYuXBVOcJ/kEvGRJB8TATIcbOYQyuOqaDnlKV2aHwHuNyzBGtuaBoIq2JSio/q3NC8OfUpGzdb99dU62S2ntdywgcPB9G48BMLcNNMcY0xX6pY4Bm1fjRa3B0Fx04SMgxMc+RknMdQVC6Eiuop+i9GKs54RHoke/L/qfvNOz1QHtJShEQDGT/9E8WHmmPX0l+ZJ2Qd2LCGD54bJy2dj2BpMTu4X0= snyssen@nixos"
  ];

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
      gnome.enable = true;
      gaming.enable = true;
    };

    grub.enable = true;
    nvidia.enable = true;
    syncthing = {
      enable = true;
      username = "snyssen";
      devices = syncthingData.devices;
      folders = {
        PrismLauncher = {
          path = "/home/snyssen/.local/share/PrismLauncher";
          devices = [ "sync.snyssen.be" ];
        };
        RetroArch = {
          path = "/home/snyssen/.config/retroarch";
          devices = [ "sync.snyssen.be" "xps" ];
        };
        Notes = {
          path = "/home/snyssen/Notes";
          devices = [ "sync.snyssen.be" "xps" "Pixel 8 Pro" ];
        };
      };
      gnomeExtension.enable = true;
    };

    logitech.enable = true;
    node-exporter.enable = true;
  };

  # Fix for time changing between boot of Windows and Linux
  time.hardwareClockInLocalTime = true;

  programs.gamemode.enable = true;

  stylix = {
    enable = true;
    image = ../../files/wallpapers/retro_gaming.jpg;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/mellow-purple.yaml";
    # polarity = "dark";

    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.fira-mono;
        name = "FiraMono Nerd Font Mono";
      };
    };
  };

  system.name = "gaming";
  system.stateVersion = "23.05";
}
