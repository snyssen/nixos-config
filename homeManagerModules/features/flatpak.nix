{inputs, lib, config, ...}:
let
  cfg = config.myHomeManager.flatpak;
in
{
  services.flatpak.enable = true;

  imports = [ inputs.flatpaks.homeManagerModules.nix-flatpak ];

  services.flatpak.packages = [
    "ca.desrt.dconf-editor"
  ];
}