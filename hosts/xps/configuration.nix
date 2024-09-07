{ config
, pkgs
, lib
, inputs
, outputs
, system
, myLib
, hm
, ...
}:
let
  syncthingData = import ../../data/syncthing.nix;
in
{
  imports =
    [
      ./hardware-configuration.nix
      inputs.nixos-hardware.nixosModules.dell-xps-15-7590-nvidia
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

    grub = {
      enable = true;
      timeout = 5;
    };
    nvidia = {
      enable = true;
      open = true;
    };
    syncthing = {
      enable = true;
      username = "snyssen";
      devices = syncthingData.devices;
      folders = {
        PrismLauncher = {
          path = "/home/snyssen/.local/share/PrismLauncher";
          devices = [ "sync.snyssen.be" "gaming" ];
        };
        RetroArch = {
          path = "/home/snyssen/.config/retroarch";
          devices = [ "sync.snyssen.be" "gaming" ];
        };
        Notes = {
          path = "/home/snyssen/Notes";
          devices = [ "sync.snyssen.be" "gaming" "Pixel 8 Pro" ];
        };
      };
      gnomeExtension.enable = true;
    };

    docker.enable = true;
  };

  programs.gamemode.enable = true;

  system.name = "gaming";
  system.stateVersion = "23.05";
}
