{ pkgs, lib, config, ... }:
let cfg = config.myNixOS.gnome;
in {
  options.myNixOS.gnome = {
    autoLogin = {
      enable = lib.mkEnableOption "autoLogin feature";
      user = lib.mkOption { default = "snyssen"; };
    };
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  environment.systemPackages = with pkgs; [
    gnomeExtensions.caffeine
    gnomeExtensions.pop-shell
    gnomeExtensions.dash-to-dock
    gnomeExtensions.syncthing-indicator
    gnomeExtensions.appindicator

    gnome-terminal
    ulauncher
  ];

  # Enable KDE Connect for use with gsconnect
  programs.kdeconnect = {
    enable = true;
    package = pkgs.gnomeExtensions.gsconnect;
  };

  services.displayManager.autoLogin = lib.mkIf cfg.autoLogin.enable {
    enable = cfg.autoLogin.enable;
    user = cfg.autoLogin.user;
  };
  # Workaround, as defined in wiki -> https://wiki.nixos.org/wiki/GNOME#Automatic_login
  systemd.services = lib.mkIf cfg.autoLogin.enable {
    "getty@tty1".enable = false;
    "autovt@tty1".enable = false;
  };
}
