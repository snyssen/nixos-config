{ pkgs, ... }: {
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
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
      ];
    };

    initExtraBeforeCompInit = ''
      # p10k config
      source ~/.p10k.zsh
    '';

    initExtra = ''
      EDITOR="code --wait"
    '';

    plugins = with pkgs; [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];
  };

  # Place p10k config file
  home.file.".p10k.zsh".source = ../../files/home/p10k-config;

  # Install fonts for use in console
  home.packages = with pkgs;
    [
      (nerdfonts.override {
        fonts = [
          "BigBlueTerminal"
          "FiraCode"
        ];
      })
    ];
  fonts.fontconfig.enable = true;
}
