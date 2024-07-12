{inputs, lib, config, ...}:
let
  cfg = config.myHomeManager.flatpak;
in
{
  imports = [ inputs.nix-flatpak.homeManagerModules.nix-flatpak ];

  options.myHomeManager.flatpak = {
    pkgs = lib.mkOption {
      type = lib.types.listOf lib.types.string;
      default = [];
    };
  };

  services.flatpak.packages = cfg.pkgs;
}