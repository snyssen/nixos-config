{ lib, config, ... }:
let
  cfg = config.myNixOS.docker;
in
{
  options.myNixOS.docker = {
    users = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ "snyssen" ];
    };
  };

  virtualisation.docker.enable = true;
  users.extraGroups.docker.members = cfg.users;
}
