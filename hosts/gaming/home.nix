{ inputs, lib, config, pkgs, user, hostname, ... }: {
  myHomeManager = {
    bundles = {
      dev.enable = true;
    };

    dconf.enable = true;
    flatpak = {
      enable = true;
      pkgs = {
        "org.libretro.RetroArch"
      };
    };
  };

  # TODO: move
  home.packages = with pkgs; [
      firefox
      prismlauncher
      gnome.dconf-editor
  ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}