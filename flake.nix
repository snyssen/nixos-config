{
  description = "snyssen's Nixos configurations";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    nix-vscode-extensions.inputs.nixpkgs.follows = "nixpkgs";
    nix-vscode-extensions.inputs.flake-utils.follows = "flake-utils";

    firefox-addons.url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
    firefox-addons.inputs.nixpkgs.follows = "nixpkgs";

    nixos-hardware.url = "github:nixos/nixos-hardware";

    stylix.url = "github:danth/stylix";
    stylix.inputs.nixpkgs.follows = "nixpkgs";
    stylix.inputs.home-manager.follows = "home-manager";
    stylix.inputs.systems.follows = "flake-utils";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { ... }@inputs:
    inputs.flake-utils.lib.eachDefaultSystemPassThrough (sys:
      let
        # Small library taken from https://github.com/vimjoyer/nixconf
        # Helps with reducing boilerplate
        myLib = import ./myLib/default.nix { inherit inputs; };
        pkgsForSys = myLib.pkgsFor sys;
      in with myLib; {
        devShell.${sys} = pkgsForSys.mkShell {
          buildInputs = with pkgsForSys; [ nixfmt nixd ];
        };

        nixosConfigurations = {
          gaming = mkSystem "gaming";
          xps = mkSystem "xps";
        };

        # Run with `nix run .#<app-name>`, e.g. `nix run .#vm-xps`
        apps.${sys} = {
          vm-gaming = mkVMFor "gaming";
          vm-xps = mkVMFor "xps";
        };

        homeManagerModules.default = ./homeManagerModules;
        nixosModules.default = ./nixosModules;

        nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
      });
}
