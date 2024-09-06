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

    docker.enable = true;
  };

  # Fix for time changing between boot of Windows and Linux
  time.hardwareClockInLocalTime = true;

  programs.gamemode.enable = true;

  system.name = "gaming";
  system.stateVersion = "23.05";
}
