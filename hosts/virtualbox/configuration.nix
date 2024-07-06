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
    gnome.enable = true
  };

  imports = [
    ./hardware-configuration.nix
  ];
  
  system.name = "virtualbox";

  system.stateVersion = "23.05";
}
