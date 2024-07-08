{
  description = "snyssen's Nixos configurations";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    nix-software-center.url = "github:snowfallorg/nix-software-center";
    # hardware.url = "github:nixos/nixos-hardware";

    # Shameless plug: looking for a way to nixify your themes and make
    # everything match nicely? Try nix-colors!
    # nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = {...}@inputs:
  let
    # Small library taken from https://github.com/vimjoyer/nixconf
    # Helps with reducing boilerplate
    myLib = import ./myLib/default.nix {inherit inputs;};
  in
  with myLib; {
    nixosConfigurations = {
      virtualbox = mkSystem "x86_64-linux" ./hosts/virtualbox/configuration.nix;
    };

    homeConfiguration = {
      "snyssen@virtualbox" = mkHome "x86_64-linux" .hosts/virtualbox/home.nix;
    };

    homeManagerModules.default = ./homeManagerModules;
    nixosModules.default = ./nixosModules;
  };
  # let 
  #   user = "snyssen";
  #   secrets = builtins.fromJSON (builtins.readFile ./secrets/secrets.json);
  # in
  # {
  #   # NixOS configuration entrypoint
  #   # Available through 'nixos-rebuild --flake .#your-hostname'
  #   nixosConfigurations = {
  #     gaming = let hostname = "gaming"; system = "x86_64-linux";
  #     in nixpkgs.lib.nixosSystem {
  #       specialArgs = { inherit inputs user secrets hostname system; }; # Pass flake inputs to our config
  #       modules = [
  #         ./common/configuration.nix
  #         ./hosts/${hostname}/configuration.nix
  #       ];
  #     };
  #     test = let hostname = "test"; system = "x86_64-linux";
  #     in nixpkgs.lib.nixosSystem {
  #       specialArgs = { inherit inputs user secrets hostname system; }; # Pass flake inputs to our config
  #       modules = [
  #         ./common/configuration.nix
  #         ./hosts/test/configuration.nix ];
  #     };
  #   };
  # };
}
