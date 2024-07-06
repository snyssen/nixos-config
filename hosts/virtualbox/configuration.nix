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
    gnome.enable = true;
  };

  imports = [
    ./hardware-configuration.nix
  ];

  # TODO: move to module
  # Bootloader.
  boot.loader = {
    timeout = null; # Wait indefinitely
    efi.canTouchEfiVariables = true;
    grub = {
      enable = true;
      device = "nodev";
      useOSProber = true;
      efiSupport = true;
    };
  };
  
  system.name = "virtualbox";

  system.stateVersion = "23.05";
}
