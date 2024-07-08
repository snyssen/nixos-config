{inputs, ...}: {
  programs.vscode = {
    enable = true;
    # TODO: find a way to propagate system architecture from flake.nix
    extensions = with inputs.nix-vscode-extensions.extensions."x86_64-linux"; [
      # TODO: only add extensions that are actually needed for all projects
      # I would like to move onto devcontainers for all projects, with extensions specific for each project defined in the project
      vscode-marketplace.redhat.ansible
      vscode-marketplace.astro-build.astro-vscode
      vscode-marketplace.aaron-bond.better-comments
      vscode-marketplace.streetsidesoftware.code-spell-checker
      vscode-marketplace.ms-vscode-remote.remote-containers
      vscode-marketplace.ms-azuretools.vscode-docker
      vscode-marketplace.hediet.vscode-drawio
      vscode-marketplace.editorconfig.editorconfig
      vscode-marketplace.dbaeumer.vscode-eslint
      vscode-marketplace.github.vscode-github-actions
      vscode-marketplace.eamodio.gitlens
      vscode-marketplace.golang.go
      vscode-marketplace.hashicorp.terraform
      vscode-marketplace.oderwat.indent-rainbow
      vscode-marketplace.whtouche.vscode-js-console-utils
      vscode-marketplace.yzhang.markdown-all-in-one
      vscode-marketplace.davidanson.vscode-markdownlint
      vscode-marketplace.unifiedjs.vscode-mdx
      vscode-marketplace.bbenoist.nix
      vscode-marketplace.christian-kohler.npm-intellisense
      vscode-marketplace.yutengjing.open-in-external-app
      vscode-marketplace.johnpapa.vscode-peacock
      vscode-marketplace.esbenp.prettier-vscode
      vscode-marketplace.ms-python.python
      vscode-marketplace.redhat.vscode-commons
      vscode-marketplace.ms-vscode-remote.vscode-remote-extensionpack
      vscode-marketplace.timonwong.shellcheck
      vscode-marketplace.bradlc.vscode-tailwindcss
      vscode-marketplace.gruntfuggly.todo-tree
      vscode-marketplace.bbenoist.vagrant
      vscode-marketplace.vscode-icons-team.vscode-icons
      vscode-marketplace.ms-vscode-remote.remote-wsl
      vscode-marketplace.redhat.vscode-yaml
    ];
  };
}