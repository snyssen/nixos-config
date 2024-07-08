{lib, config, pkgs, ...}:
let
  cfg = config.myNixOS.nh;
in
{
  options.myNixOS.nh = {
    username = lib.mkOption {
      default = "snyssen";
    };
  };

  environment = {
    sessionVariables = {
      FLAKE = "/home/${username}/nixos-config";
    };
    systemPackages = [ pkgs.nh ];
  };

}