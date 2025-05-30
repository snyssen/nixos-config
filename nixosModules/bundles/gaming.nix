{ lib, pkgs, ... }: {
  myNixOS = { steam.enable = true; };

  environment.systemPackages = with pkgs; [ lutris nexusmods-app-unfree ];
}
