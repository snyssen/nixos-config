{ lib, ... }: {
  myNixOS = {
    gnome.enable = true;
    gnome.autoLogin.enable = lib.mkDefault true;
    kbd-layout.enable = true;
    kbd-layout.additionalLayouts = [ "be" ];
    i18n.enable = true;
    nh.enable = true;
  };
}
