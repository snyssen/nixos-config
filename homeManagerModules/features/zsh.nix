{pkgs, ...}: {
  # TODO: set-up p10k configuration
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
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
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/.p10k.zsh
    '';

    initExtra = ''
      EDITOR="code --wait"
    '';

    plugins = with pkgs; [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = ../../files/home/p10k-config;
        file = "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/.p10k.zsh";
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