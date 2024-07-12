{inputs, outputs, pkgs, lib, ...}: {
  myHomeManager = {
    bundles = {
      dev.enable = true;
    };
    
    dconf.enable = true;
    flatpak = {
      enable = true;
      pkgs = [
        "org.libretro.RetroArch"
      ];
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}