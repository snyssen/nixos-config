{...}: {
  myNixOS = {
    gnome.enable = true;
    kbd-layout.enable = true;
    kbd-layout.additionalLayouts = ["be"];
    i18n.enable = true;
    nh.enable = true;
  };
}