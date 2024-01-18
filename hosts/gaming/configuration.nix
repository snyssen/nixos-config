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

  # Enable OpenGL
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];
  programs.xwayland.enable = true;

  hardware.nvidia = {

    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    powerManagement.enable = false;
    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of 
    # supported GPUs is at: 
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
    # Only available from driver 515.43.04+
    # Currently alpha-quality/buggy, so false is currently the recommended setting.
    open = true;

    # Enable the Nvidia settings menu,
	  # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

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
    folders = secrets.syncthing.folders;
  };

  networking = {
    # Open ports in the firewall for:
    # - syncthing
    firewall.allowedTCPPorts = [ 22000 ];
    firewall.allowedUDPPorts = [ 22000 21027 ];
  };

  programs.gamemode.enable = true;
}
