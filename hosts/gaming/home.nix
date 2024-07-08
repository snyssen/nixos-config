{ inputs, lib, config, pkgs, user, hostname, ... }: {
  myHomeManager = {
    bundles = {
      dev.enable = true;
    };

    dconf.enable = true;
  };

  # TODO: move
  home.packages = with pkgs; [
      prismlauncher
      gnome.dconf-editor
      (retroarch.override {
          cores = with libretro; [
              pcsx2
          ];
      })
  ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}