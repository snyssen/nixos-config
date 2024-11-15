{
  description = "snyssen's Nixos configurations";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";

    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    nix-vscode-extensions.inputs.nixpkgs.follows = "nixpkgs";
    nix-vscode-extensions.inputs.flake-utils.follows = "flake-utils";

    firefox-addons.url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
    firefox-addons.inputs.nixpkgs.follows = "nixpkgs";
    firefox-addons.inputs.flake-utils.follows = "flake-utils";

    nixos-hardware.url = "github:nixos/nixos-hardware";

    stylix.url = "github:danth/stylix";
    stylix.inputs.nixpkgs.follows = "nixpkgs";
    stylix.inputs.home-manager.follows = "home-manager";
    stylix.inputs.flake-utils.follows = "flake-utils";
    stylix.inputs.systems.follows = "flake-utils";

    # Shameless plug: looking for a way to nixify your themes and make
    # everything match nicely? Try nix-colors!
    # nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = { ... }@inputs: inputs.flake-utils.lib.eachDefaultSystemPassThrough (sys:
    let
      # Small library taken from https://github.com/vimjoyer/nixconf
      # Helps with reducing boilerplate
      myLib = import ./myLib/default.nix { inherit inputs; };
      pkgsForSys = myLib.pkgsFor sys;
    in
    with myLib;
    {
      devShell.${sys} = pkgsForSys.mkShell {
        buildInputs = with pkgsForSys; [ nixpkgs-fmt ];
      };

      nixosConfigurations = {
        gaming = mkSystem "gaming";
        xps = mkSystem "xps";
      };

      apps.${sys} = {
        vm-gaming = mkAppVM "gaming";
        vm-xps = mkAppVM "xps";
      };

      homeManagerModules.default = ./homeManagerModules;
      nixosModules.default = ./nixosModules;
    }
  );
}
