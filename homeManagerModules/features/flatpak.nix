{inputs, lib, config, ...}:
let
  cfg = config.myHomeManager.flatpak;
in
{
  imports = [ inputs.nix-flatpak.homeManagerModules.nix-flatpak ];

  services.flatpak.packages = [
    "ca.desrt.dconf-editor"
    "ca.hamaluik.Timecop"
  ];
}