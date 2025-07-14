{ lib, ... }: {
  myHomeManager = {
    zsh.enable = true;
    zsh.atuin.enable = lib.mkDefault true;
    git.enable = true;
    vscode.enable = true;
    direnv.enable = true;
  };
}
