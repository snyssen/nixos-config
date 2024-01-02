{ inputs, outputs, lib, config, pkgs, user, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

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

  networking.hostName = "test"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # Configure keymap in X11
  services.xserver = {
    layout = "be";
    xkbVariant = "";
  };

  # Configure console keymap
  console.keyMap = "be";
}
