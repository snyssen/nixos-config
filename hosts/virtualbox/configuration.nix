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
    user.enable = true;
    gnome.enable = true;
    kbd-layout.enable = true;
  };

  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;

  system.name = "virtualbox";

  system.stateVersion = "23.05";
}
