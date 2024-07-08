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
}: {
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
        "test-deleteme" = {
          path = "/home/snyssen/Documents";
          devices = [ "sync.snyssen.be" ];
        };
      };
    };
  };

  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;

  system.name = "virtualbox";

  system.stateVersion = "23.05";
}
