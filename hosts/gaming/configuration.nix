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
    };

    grub.enable = true;
    nvidia.enable = true;
    syncthing = {
      enable = true;
      username = "snyssen";
      devices = {
        # TODO: export into a "data" module for easy re-use
        "sync.snyssen.be" = {
          id = "6QHAMO3-PARP6UW-3Y5J7I4-P5PN2C5-RHS6OMP-QCSBP5Z-6OBZMC3-NZM65QT";
        };
      };
      folders = {
        PrismLauncher = {
          path = "/home/snyssen/.local/share/PrismLauncher";
          devices = [ "sync.snyssen.be" ];
        };
        # RetroArch = {
        #   path = "/home/snyssen/.config/retroarch";
        #   devices = [ "sync.snyssen.be" ];
        # };
      };
    };
  };

  # Fix for time changing between boot of Windows and Linux
  time.hardwareClockInLocalTime = true;

  programs.gamemode.enable = true;
  
  system.name = "gaming";
  system.stateVersion = "23.05";
}
