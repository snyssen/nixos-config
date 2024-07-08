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
}