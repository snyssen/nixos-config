{inputs, outputs, pkgs, lib, ...}: {
  myHomeManager = {
    zsh.enable = true;
    git.enable = true;
    dconf.enable = true;
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}