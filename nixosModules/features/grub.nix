{lib, config, ...}:
let
  cfg = config.myNixOs.grub;
in
{

  options.myNixOS.grub = {
    timeout = lib.mkOption {
      default = null;
      description = ''
        Duration (in seconds) until grub boots in default menu item. Defaults to null, i.e. waits indefinitely
      ''
    };
  };

  boot.loader = {
    timeout = cfg.timeout;
    # efi.canTouchEfiVariables = true;
    grub = {
      enable = true;
      device = "nodev";
      useOSProber = true;
      efiSupport = true;
    };
  };
}