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

## [WIP] Deployment with [nixos-anywhere](https://nix-community.github.io/nixos-anywhere/quickstart.html)

Use live minimal image of nixos, then follow instructions at: https://nixos.org/manual/nixos/stable/#sec-installation-booting-networking

In particular you want:

- Change to keyboard layout: `sudo loadkeys /etc/kbd/keymaps/i386/azerty/be-latin1.map.gz`
- Connected to Wifi if needed: `nmtui`
- Set root password: sudo passwd

Most of what is needed is explained at the start of the terminal session. SSH should be enabled automatically and you should be able to login as root. Then from another computer:

```sh
echo "my-super-safe-password" > /tmp/secret.key

nix run github:nix-community/nixos-anywhere -- --flake .#gaming --target-host snyssen@192.168.1.108 --generate-hardware-config nixos-generate-config ./hosts/gaming/hardware-configuration.nix --disk-encryption-keys /tmp/secret.key /tmp/secret.key
```
