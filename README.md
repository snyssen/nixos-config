# nixos-config

## Commands

> [!TIP]
> You can use the [Nix Determinate installter](https://github.com/DeterminateSystems/nix-installer) to install nix on any Linux distro

### Unlock secrets file (depends on having the GPG private key locally)

```sh
nix shell nixpkgs#git-crypt --command git-crypt unlock
```

### Switch to specific config, e.g. gaming

```sh
sudo nixos-rebuild switch --flake .#gaming
```
