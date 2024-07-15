{pkgs, ...}: {
  # TODO: set-up p10k configuration
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
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
      # p10k config
      source ~/.p10k.zsh
    '';

    initExtra = ''
      EDITOR="code --wait"
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
        name = "powerlevel10k-config";
        src = ../../files/home/p10k-config;
        file = "p10k.zsh";
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

  # Install fonts for use in console
  home.packages = with pkgs;
  [
    (nerdfonts.override { fonts = [
      "BigBlueTerminal"
      "FiraCode"
    ]; })
  ];
  fonts.fontconfig.enable = true;
}