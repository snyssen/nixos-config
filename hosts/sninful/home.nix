{
  pkgs,
  ...
}:
{

  #
  ## WORKAROUNDS
  #

  #########################

  myHomeManager = {
    bundles = {
      dev.enable = true;
    };

    git.signingKeyFilename = "id_ed25519.pub";

    dconf.enable = true;
    firefox.enable = true;
  };

  # TODO: move
  home.packages = with pkgs; [
    sweethome3d.application
    obsidian
    librewolf
    vesktop
    onlyoffice-desktopeditors
    protonmail-desktop
    picard
    vlc
    ghostty
    annotator
    element-desktop
  ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
