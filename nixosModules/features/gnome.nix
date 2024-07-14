{pkgs, lib, ...}:
let
  cfg = config.myNixOS.gnome;
in
{
  options.myNixOS.gnome = {
    autoLogin = {
      enable = lib.mkEnableOption "autoLogin feature";
      user = lib.mkOption {
        default = "snyssen";
      };
    };
  };

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

  services.xserver.displayManager.autoLogin = lib.mkIf cfg.autoLogin.enable {
    enable = cfg.autoLogin.enable;
    user = cfg.autoLogin.user;
  };
  # Workaround, as defined in wiki -> https://wiki.nixos.org/wiki/GNOME#Automatic_login
  systemd.services = lib.mkIf cfg.autoLogin.enable {
    "getty@tty1".enable = false;
    "autovt@tty1".enable = false;
  };
}