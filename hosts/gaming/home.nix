# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)

{ inputs, lib, config, pkgs, user, ... }: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = (_: true);
    };
  };

  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";
  };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git = {
    enable = true;
    userName  = "snyssen";
    userEmail = "dev@snyssen.be";
  };
  programs.direnv.enable = true;
  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "powerlevel10k/powerlevel10k";
      plugins = [
        "colored-man-pages"
        "colorize"
        "docker-compose"
        "docker"
        "dotenv"
        "dotnet"
        "git"
        "npm"
        "screen"
        "vscode"
        "zsh-autosuggestions"
        "zsh-syntax-highlighting"
      ];
    };

    initExtraBeforeCompInit = ''
      # p10k instant prompt
      P10K_INSTANT_PROMPT="$XDG_CACHE_HOME/p10k-instant-prompt-''${(%):-%n}.zsh"
      [[ ! -r "$P10K_INSTANT_PROMPT" ]] || source "$P10K_INSTANT_PROMPT"
    '';

    plugins = with pkgs; [
      {
        # A prompt will appear the first time to configure it properly
        # make sure to select MesloLGS NF as the font in Konsole
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "zsh-autosuggestions";
        src = pkgs.zsh-autosuggestions;
      }
      {
        name = "you-should-use";
        src = pkgs.zsh-you-should-use;
      }
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.zsh-syntax-highlighting;
      }
    ];
  };
  programs.vscode = {
    enable = true;
    extensions = with inputs.nix-vscode-extensions.extensions."x86_64-linux"; [
      vscode-marketplace.redhat.ansible
      vscode-marketplace.astro-build.astro-vscode
      vscode-marketplace.aaron-bond.better-comments
      vscode-marketplace.streetsidesoftware.code-spell-checker
      vscode-marketplace.ms-vscode-remote.remote-containers
      vscode-marketplace.ms-azuretools.vscode-docker
      vscode-marketplace.hediet.vscode-drawio
      vscode-marketplace.EditorConfig.EditorConfig
      vscode-marketplace.dbaeumer.vscode-eslint
      vscode-marketplace.github.vscode-github-actions
      vscode-marketplace.eamodio.gitlens
      vscode-marketplace.golang.go
      vscode-marketplace.hashicorp.terraform
      vscode-marketplace.oderwat.indent-rainbow
      vscode-marketplace.whtouche.vscode-js-console-utils
      vscode-marketplace.yzhang.markdown-all-in-one
      vscode-marketplace.DavidAnson.vscode-markdownlint
      vscode-marketplace.unifiedjs.vscode-mdx
      vscode-marketplace.bbenoist.Nix
      vscode-marketplace.christian-kohler.npm-intellisense
      vscode-marketplace.YuTengjing.open-in-external-app
      vscode-marketplace.johnpapa.vscode-peacock
      vscode-marketplace.esbenp.prettier-vscode
      vscode-marketplace.ms-python.python
      vscode-marketplace.redhat.vscode-commons
      vscode-marketplace.ms-vscode-remote.vscode-remote-extensionpack
      vscode-marketplace.timonwong.shellcheck
      vscode-marketplace.bradlc.vscode-tailwindcss
      vscode-marketplace.Gruntfuggly.todo-tree
      vscode-marketplace.bbenoist.vagrant
      vscode-marketplace.vscode-icons-team.vscode-icons
      vscode-marketplace.ms-vscode-remote.remote-wsl
      vscode-marketplace.redhat.vscode-yaml
    ];
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
