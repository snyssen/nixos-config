{ inputs, lib, config, pkgs, user, hostname, ... }: {
  myHomeManager = {
    bundles = {
      dev.enable = true;
    };

    dconf.enable = true;
    firefox.enable = true;
  };

  # TODO: move
  home.packages = with pkgs; [
    prismlauncher
    dconf-editor
    (retroarch.override {
      cores = with libretro; [
        pcsx2
        pcsx-rearmed
      ];
    })
    sweethome3d.application
    obsidian
    librewolf
    webcord-vencord
    onlyoffice-bin
  ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
