{pkgs, ...}: {
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  environment.systemPackages = with pkgs; [
    pkgs.gnomeExtensions.caffeine
    pkgs.gnomeExtensions.pop-shell
    pkgs.gnomeExtensions.gsconnect
    pkgs.gnomeExtensions.dash-to-dock
    pkgs.gnomeExtensions.syncthing-indicator
  ];

  dconf = {
    enable = true;
    settings."org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      enable-hot-corners = false;
    };
    settings."org/gnome/desktop/screensaver".lock-delay = lib.hm.gvariant.mkUint32 300;
    settings."org/gnome/desktop/session".idle-delay = lib.hm.gvariant.mkUint32 600;
    settings."org/gnome/shell/extensions/pop-shell".tile-by-default = true;
  };
}