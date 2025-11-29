{
  pkgs,
  lib,
  inputs,
  ...
}:
let
  syncthingData = import ../../data/syncthing.nix;
in
{

  #
  ## WORKAROUNDS
  #

  # nixpkgs.config.permittedInsecurePackages = [
  #   "libsoup-2.74.3"
  # ];

  # Fix touchpad not responding -> https://discourse.nixos.org/t/touchpad-not-recognizable/19198/10
  boot.blacklistedKernelModules = [ "elan_i2c" ];

  #########################

  imports = [
    inputs.disko.nixosModules.disko
    ./disk-config.nix
    ./hardware-configuration.nix
    inputs.stylix.nixosModules.stylix
  ];

  specialisation = {
    gnome.configuration = {
      myNixOS.bundles = {
        gnome.enable = true;
        cosmic.enable = false;
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
      cosmic.enable = lib.mkDefault true;
    };

    grub = {
      enable = true;
      timeout = 10;
    };
    syncthing = {
      enable = true;
      username = "snyssen";
      devices = syncthingData.devices;
      folders = {
        Notes = {
          path = "/home/snyssen/Notes";
          devices = [
            "sync.snyssen.be"
            "xps"
            "Pixel 8 Pro"
            "gaming"
          ];
        };
      };
    };

    printing.enable = true;
    tailscale.enable = true;
  };

  environment.systemPackages = [
    pkgs.htop
  ];

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

  system.name = "sninful";
  system.stateVersion = "23.05";
}
