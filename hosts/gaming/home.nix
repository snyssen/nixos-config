{ inputs, lib, config, pkgs, user, hostname, ... }: {
    home.packages = with pkgs; [
        prismlauncher
        gnome.dconf-editor
        (retroarch.override {
            cores = with libretro; [
                pcsx2
            ];
        })
    ];
}