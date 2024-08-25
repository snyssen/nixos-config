{ lib, config, inputs, outputs, myLib, pkgs, ... }:
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
    zsh.enable = lib.mkEnableOption "zsh shell for user";
  };

  programs.zsh.enable = cfg.zsh.enable;
  users.users.${cfg.username} = {
    isNormalUser = true;
    shell = lib.mkIf cfg.zsh.enable pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" ];
    initialPassword = "123456789";
  };

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
