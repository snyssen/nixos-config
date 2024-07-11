{inputs, lib, config, ...}:
let
  cfg = config.myHomeManager.flatpak;
in
{
  services.flatpak.enable = true;

  imports = [ inputs.nix-flatpak.homeManagerModules.nix-flatpak ];

  services.flatpak.packages = [
    "ca.desrt.dconf-editor"
    "ca.hamaluik.Timecop"
  ];
}