{ lib, ... }: {
  dconf = {
    enable = true;
    settings."org/gnome/desktop/interface" = {
      # color-scheme = "prefer-dark";
      enable-hot-corners = false;
    };
    settings."org/gnome/desktop/screensaver".lock-delay = lib.hm.gvariant.mkUint32 300;
    settings."org/gnome/desktop/session".idle-delay = lib.hm.gvariant.mkUint32 600;
    settings."org/gnome/shell/extensions/pop-shell".tile-by-default = true;
  };
}
