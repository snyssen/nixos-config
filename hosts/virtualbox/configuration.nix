{
  config,
  pkgs,
  lib,
  inputs,
  outputs,
  system,
  myLib,
  hm,
  ...
}: {
  # myNixOS = {

  # };

  imports = [ <nixpkgs/nixos/modules/installer/virtualbox-demo.nix> ];
  
  system.name = "virtualbox";

  system.stateVersion = "23.05";
}