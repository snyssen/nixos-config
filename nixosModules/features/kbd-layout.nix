{lib, config, ...}:
let
  cfg = config.myNixOS.kbd-layout;
in
{
  options.myNixOS.kbd-layout = {
    layout = lib.mkOption {
      default = "fr";
      description = ''
        Keyboartd layout to apply
      '';
    };
    additionalLayouts = lib.mkOption {
      default = [];
      description = ''
        Additional keybaord layouts to apply
      '';
    };
  };

  # Configure keymap in X11
  services.xserver = {
    # Concatenate as e.g. "fr,be,us"
    layout = lib.strings.concatMapStringsSep "," [
      cfg.layout
    ]
    ++ cfg.additionalLayouts;
    xkbVariant = "";
  };

  # Configure console keymap
  console.keyMap = cfg.layout;
}