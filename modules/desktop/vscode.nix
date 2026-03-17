{ config, pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;

    extensions = with pkgs.vscode-extensions; [
      jnoortheen.nix-ide #Suporte para arquivos nix
      catppuccin.catppuccin-vsc #Tema catppuccin
      # Docker/Dev
      ms-vscode-remote.remote-containers
      ms-azuretools.vscode-docker
    ];

    userSettings = {
      "editor.fontSize" = 14;
      "editor.fontFamily" = "'JetBrainsMono Nerd Font', 'monospace'";
      "workbench.colorTheme" = "Catppuccin Mocha";
      "editor.semanticHighlighting.enabled" = true;
      "terminal.integrated.defaultProfile.linux" = "zsh";
      "window.titleBarStyle" = "custom";
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nil";
    };
  };
}
