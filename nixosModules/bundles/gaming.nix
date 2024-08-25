{ lib, pkgs, ... }: {
  myNixOS = {
    steam.enable = true;
  };

  environment.systemPackages = with pkgs; [
    bottles
  ];
}
