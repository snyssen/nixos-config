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

    # hardware.url = "github:nixos/nixos-hardware";

    # Shameless plug: looking for a way to nixify your themes and make
    # everything match nicely? Try nix-colors!
    # nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = { ... }@inputs:
    let
      # Small library taken from https://github.com/vimjoyer/nixconf
      # Helps with reducing boilerplate
      myLib = import ./myLib/default.nix { inherit inputs; };
    in
    with myLib; {
      devShells = builtins.listToAttrs (map
        (sys:
          let pkgs = inputs.nixpkgs.legacyPackages.${sys}; in
          {
            name = sys;
            value = {
              default = pkgs.mkShell {
                buildInputs = with pkgs; [
                  nixpkgs-fmt
                ];
              };
            };
          })
        inputs.flake-utils.lib.defaultSystems);

      nixosConfigurations = {
        virtualbox = mkSystem "virtualbox";
        gaming = mkSystem "gaming";
      };

      homeManagerModules.default = ./homeManagerModules;
      nixosModules.default = ./nixosModules;
    };
}
