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

  # nixpkgs.config.permittedInsecurePackages = [
  #   "libsoup-2.74.3"
  # ];

  #########################

  imports = [
    inputs.disko.nixosModules.disko
    ./disk-config.nix
    ./hardware-configuration.nix
    inputs.stylix.nixosModules.stylix
  ];

  myNixOS = {
    #* WIP: GPU passthrough
    gpu-passthrough = {
      enable = false;
      vfioIds = [
        "10de:1e82" # RTX2080 VGA
        "10de:10f8" # RTX2080 Audio
      ];
    };

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
      timeout = 10;
    };
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
          devices = [
            "sync.snyssen.be"
            "xps"
          ];
        };
        Notes = {
          path = "/home/snyssen/Notes";
          devices = [
            "sync.snyssen.be"
            "xps"
            "Pixel 8 Pro"
          ];
        };
      };
    };

    logitech.enable = true;
    node-exporter.enable = true;
    docker.enable = true;
    tailscale.enable = true;
  };

  environment.systemPackages = [
    pkgs.smartmontools
    pkgs.tmux
    pkgs.htop
  ];

  # Fix for time changing between boot of Windows and Linux
  time.hardwareClockInLocalTime = true;

  programs.gamemode.enable = true;

  stylix = {
    enable = true;
    image = ../../files/wallpapers/Elite_wallpaper_4k_8.jpg;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/horizon-dark.yaml";
    polarity = "dark";

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
