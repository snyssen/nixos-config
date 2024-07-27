{
  description = "snyssen's Nixos configurations";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";

    firefox-addons.url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
    firefox-addons.inputs.nixpkgs.follows = "nixpkgs";

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
      virtualbox = mkSystem "virtualbox";
      gaming = mkSystem "gaming";
    };

    homeConfigurations = {
      "snyssen@virtualbox" = mkHome "x86_64-linux" .hosts/virtualbox/home.nix;
      "snyssen@gaming" = mkHome "x86_64-linux" .hosts/gaming/home.nix;
    };

    homeManagerModules.default = ./homeManagerModules;
    nixosModules.default = ./nixosModules;
  };
}
