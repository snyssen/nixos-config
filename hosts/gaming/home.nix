{
  inputs,
  lib,
  config,
  pkgs,
  user,
  hostname,
  ...
}:
{

  #
  ## WORKAROUNDS
  #

  # prevent hibernation due to power issues with NVIDIA cards
  dconf.settings."org/gnome/settings-daemon/plugins/power".sleep-inactive-ac-type = "nothing";
  dconf.settings."org/gnome/settings-daemon/plugins/power".sleep-inactive-battery-type = "suspend";

  #########################

  myHomeManager = {
    bundles = {
      dev.enable = true;
    };

    dconf.enable = true;
    firefox.enable = true;

    git.signingKeyFilename = "id_ed25519.pub";
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
    onlyoffice-desktopeditors
    protonmail-desktop
    ghostty
    caligula
    zenity
    protontricks
    p7zip
    signal-desktop
    fluffychat
    telegram-desktop
  ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
