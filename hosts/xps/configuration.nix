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
      inputs.stylix.nixosModules.stylix
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
    logitech.enable = true;
  };

  # TODO: export
  stylix = {
    enable = true;
    image = ../../files/wallpapers/bear1.jpg;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/atelier-estuary.yaml";
    # polarity = "dark";

    fonts = {
      monospace = {
        package = (pkgs.nerdfonts.override {
          fonts = [
            "FiraCode"
          ];
        });
        name = "FiraCode Nerd Font Mono";
      };
    };
  };

  programs.gamemode.enable = true;

  system.name = "xps";
  system.stateVersion = "23.05";
}
