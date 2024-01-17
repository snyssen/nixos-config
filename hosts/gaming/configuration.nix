{ inputs, outputs, lib, config, pkgs, user, secrets, hostname, ... }:
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

  # Fix for time changing between boot of Windows and Linux
  time.hardwareClockInLocalTime = true;


  # Configure keymap in X11
  services.xserver = {
    layout = "fr";
    xkbVariant = "";
  };

  # Configure console keymap
  console.keyMap = "fr";

  services.syncthing = {
    enable = true;
    user = "${user}";
    dataDir = "/home/${user}/Documents";
    configDir = "/home/${user}/Documents/.config/syncthing";
    overrideDevices = true;
    overrideFolders = true;
    devices = secrets.syncthing.devices;
  };

  networking = {
    # Open ports in the firewall for:
    # - syncthing
    firewall.allowedTCPPorts = [ 22000 ];
    firewall.allowedUDPPorts = [ 22000 21027 ];
  };
}
