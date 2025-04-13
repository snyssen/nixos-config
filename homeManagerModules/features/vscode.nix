{ inputs, pkgs, ... }: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;
    # TODO: look into defining multiple profiles
    profiles.default = {
      # TODO: find a way to propagate system architecture from flake.nix
      extensions =
        with inputs.nix-vscode-extensions.extensions."x86_64-linux".vscode-marketplace; [
          # TODO: only add extensions that are actually needed for all projects
          # I would like to move onto devcontainers for all projects, with extensions specific for each project defined in the project
          mkhl.direnv
          redhat.ansible
          astro-build.astro-vscode
          aaron-bond.better-comments
          streetsidesoftware.code-spell-checker
          #ms-vscode-remote.remote-containers
          ms-azuretools.vscode-docker
          hediet.vscode-drawio
          editorconfig.editorconfig
          dbaeumer.vscode-eslint
          github.vscode-github-actions
          eamodio.gitlens
          golang.go
          #hashicorp.terraform
          oderwat.indent-rainbow
          whtouche.vscode-js-console-utils
          yzhang.markdown-all-in-one
          davidanson.vscode-markdownlint
          unifiedjs.vscode-mdx
          jnoortheen.nix-ide
          christian-kohler.npm-intellisense
          yutengjing.open-in-external-app
          johnpapa.vscode-peacock
          esbenp.prettier-vscode
          ms-python.python
          redhat.vscode-commons
          # ms-vscode-remote.vscode-remote-extensionpack
          timonwong.shellcheck
          bradlc.vscode-tailwindcss
          gruntfuggly.todo-tree
          #bbenoist.vagrant
          vscode-icons-team.vscode-icons
          # ms-vscode-remote.remote-wsl
          redhat.vscode-yaml
          # ms-dotnettools.vscode-dotnet-runtime
          # ms-dotnettools.csharp
          # ms-dotnettools.csdevkit
        ];
      userSettings = {
        "git.autofetch" = "all";
        "git.enableSmartCommit" = true;
        "git.confirmSync" = false;
        "editor.multiCursorModifier" = "ctrlCmd";
        "editor.formatOnSave" = true;
      };
      keybindings = [
        # Browser-like tab navigation, smth that should be the default let's be honest...
        {
          "key" = "ctrl+tab";
          "command" = "workbench.action.nextEditor";
        }
        {
          "key" = "ctrl+shift+tab";
          "command" = "workbench.action.previousEditor";
        }
        # Save all files
        {
          "key" = "ctrl+shift+s";
          "command" = "workbench.action.files.saveFiles";
        }
      ];
    };
  };
}
