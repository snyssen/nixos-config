{lib, config, ...}:
let
  cfg = config.myNixOS.kbd-layout;
  opts = options.myNixOS.kbd-layout;
in
{
  opts = {
    layout = lib.mkOption {
      default = "fr";
      description = ''
        Keyboartd layout to apply
      '';
    };
  };

  # Configure keymap in X11
  services.xserver = {
    layout = cfg.layout;
    xkbVariant = "";
  };

  # Configure console keymap
  console.keyMap = cfg.layout;
}