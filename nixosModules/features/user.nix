{lib, config, inputs, outputs, myLib, pkgs, ...}:
let
  cfg = config.myNixOS.user;
in
{
  options.myNixOS.user = {
    username = lib.mkOption {
      default = "snyssen";
    };
    home-manager = {
      enable = lib.mkEnableOption "enable home-manager for user";
      config = lib.mkOption {
        description = "Specify the nix module responsible for the configuration of home-manager";
        example = "./home.nix";
      };
    };
    defaultShell = lib.mkOption {
      type = lib.types.package;
      description = "The default shell for all users";
      default = pkgs.bash;
    };
  };

  users.users.${cfg.username} = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
    initialPassword = "123456789";
  };

  users.defaultUserShell = cfg.defaultShell;

  home-manager = lib.mkIf cfg.home-manager.enable {
    useGlobalPkgs = true;
    useUserPackages = true;

    extraSpecialArgs = {
      inherit inputs;
      inherit myLib;
      outputs = inputs.self.outputs;
    };
    users.${cfg.username}.imports = [
      outputs.homeManagerModules.default
      (import cfg.home-manager.config)
    ];
  };
}