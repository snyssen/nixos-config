{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.myNixOS.cosmic;
in
{
  options.myNixOS.cosmic = {
    autoLogin = {
      enable = lib.mkEnableOption "autoLogin feature";
      user = lib.mkOption { default = "snyssen"; };
    };
  };

  services.displayManager.cosmic-greeter.enable = true;
  services.desktopManager.cosmic.enable = true;

  services.displayManager.autoLogin = lib.mkIf cfg.autoLogin.enable {
    enable = cfg.autoLogin.enable;
    user = cfg.autoLogin.user;
  };
}
