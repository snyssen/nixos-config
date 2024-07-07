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
    };

    gnome.enable = true;
    kbd-layout.enable = true;
    kbd-layout.additionalLayouts = ["be"];
  };

  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;

  system.name = "virtualbox";

  system.stateVersion = "23.05";
}
