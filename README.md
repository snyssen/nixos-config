# nixos-config

## Initial setup

1. Install NixOS using the [official ISO](https://nixos.org/download/)
2. Generate an SSH key with `ssh-keygen` and save the public key in github
3. Start a nix shell with git in it

```sh
nix --extra-experimental-features 'nix-command flakes' shell nixpkgs#git
```

4. Clone this repo

```sh
git clone git@github.com:snyssen/nixos-config.git && cd nixos-config
```

5. Generate a new hardware-configuration.nix file for your host and add it to staged changes

```sh
nixos-generate-config --dir hosts/[host]/
git add hosts/[host]/hardware-configuration.nix
```

6. Switch to the host configuration

```sh
sudo nixos-rebuild switch --flake .#[host]
```

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
