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
  };

  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;

  system.name = "virtualbox";

  system.stateVersion = "23.05";
}
