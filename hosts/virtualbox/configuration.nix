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

    # TODO: create bundles
    gnome.enable = true;
    kbd-layout.enable = true;
    kbd-layout.additionalLayouts = ["be"];
    i18n.enable = true;
    nh.enable = true;
    syncthing = {
      enable = true;
      username = "snyssen";
      devices = {
        "sync.snyssen.be" = data.syncthing.devices."sync.snyssen.be";
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
