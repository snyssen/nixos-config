{lib, config, ...}:
let
  cfg = config.myHomeManager.git;
in
{
  options.myHomeManager.git = {
    username = lib.mkOption {
      default = "snyssen";
    };
    email = lib.mkOption {
      default = "dev@snyssen.be";
    };
  };

  programs.git = {
    enable = true;
    userName  = cfg.username;
    userEmail = cfg.email;
  };
}