{lib, config, pkgs, inputs,...}:
let
  cfg = config.myHomeManager.firefox;
in
{
  options.myHomeManager.firefox = {
    user = lib.mkOption {
      default = "snyssen";
    };
  };

  programs.firefox = {
    enable = true;
    profiles.${cfg.user} = {
      # TODO: make firefox more private using settings
      # TODO: add Floccus and TamperMonkey (and see if they can be configured declaratively)
      extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
        bitwarden
        ublock-origin
      ];
    };
  };
}