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
      # TODO: Don't forget to change with the hardware-configuration built especially for the device !
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
    syncthing = {
      enable = true;
      username = "snyssen";
      # TODO: update devices with this new one
      devices = syncthingData.devices;
      folders = {
        PrismLauncher = {
          path = "/home/snyssen/.local/share/PrismLauncher";
          devices = [ "sync.snyssen.be" ];
        };
        RetroArch = {
          path = "/home/snyssen/.config/retroarch";
          devices = [ "sync.snyssen.be" ];
        };
        Notes = {
          path = "/home/snyssen/Notes";
          devices = [ "sync.snyssen.be" "Pixel 8 Pro" ];
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
