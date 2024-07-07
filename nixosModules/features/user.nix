{lib, config, ...}:
let
  cfg = config.myNixOS.user;
in
{
  options.myNixOS.user = {
    username = lib.mkOption {
      default = "snyssen";
    };
  };

  users.users.${cfg.username} = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
    initialPassword = "123456789";
  };
}