{ lib, config, pkgs, ... }:
let cfg = config.myNixOS.nh;
in {
  options.myNixOS.nh = { username = lib.mkOption { default = "snyssen"; }; };

  environment = {
    sessionVariables = { NH_FLAKE = "/home/${cfg.username}/nixos-config"; };
    systemPackages = [ pkgs.nh ];
  };

}
