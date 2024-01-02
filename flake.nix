{
  description = "Your new nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    # hardware.url = "github:nixos/nixos-hardware";

    # Shameless plug: looking for a way to nixify your themes and make
    # everything match nicely? Try nix-colors!
    # nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = { nixpkgs, home-manager, ... }@inputs:
  let 
    user = "snyssen";
  in
  {
    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      gaming = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs user; }; # Pass flake inputs to our config
        modules = [
          ./common/configuration.nix
          ./hosts/gaming/configuration.nix ];
      };
      test = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs user; }; # Pass flake inputs to our config
        modules = [
          ./common/configuration.nix
          ./hosts/test/configuration.nix ];
      };
    };
  };
}
