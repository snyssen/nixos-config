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
    retroarch-full
    sweethome3d.application
    obsidian
    librewolf
    vesktop
    onlyoffice-bin
    protonmail-desktop
    signal-desktop
    picard
    dbeaver-bin
    vlc
  ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
