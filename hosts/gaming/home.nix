{ inputs, lib, config, pkgs, user, hostname, ... }: {
    home.packages = with pkgs; [
        prismlauncher
    ];
}