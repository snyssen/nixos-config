{ lib, ... }: {
  myHomeManager = {
    zsh.enable = true;
    zsh.atuin.enable = lib.mkDefault false;
    zsh.fzf.enable = lib.mkDefault true;
    zsh.intelli-shell.enable = lib.mkDefault false;
    git.enable = true;
    vscode.enable = true;
    direnv.enable = true;
  };
}
