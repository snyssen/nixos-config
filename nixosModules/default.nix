{ pkgs, config, lib, inputs, outputs, myLib, ... }:
let
  cfg = config.myNixOS;

  # Taking all modules in ./features and adding enables to them
  features = myLib.extendModules (name: {
    extraOptions = {
      myNixOS.${name}.enable =
        lib.mkEnableOption "enable my ${name} configuration";
    };

    configExtension = config: (lib.mkIf cfg.${name}.enable config);
  }) (myLib.filesIn ./features);

  # Taking all module bundles in ./bundles and adding bundle.enables to them
  bundles = myLib.extendModules (name: {
    extraOptions = {
      myNixOS.bundles.${name}.enable =
        lib.mkEnableOption "enable ${name} module bundle";
    };

    configExtension = config: (lib.mkIf cfg.bundles.${name}.enable config);
  }) (myLib.filesIn ./bundles);

in {
  imports = [ inputs.home-manager.nixosModules.home-manager ] ++ features
    ++ bundles;

  config = {
    nix.settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };
    nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    nixpkgs.config.allowUnfree = true;
    nixpkgs.overlays = [ inputs.nix-vscode-extensions.overlays.default ];
  };
}
