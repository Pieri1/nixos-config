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
      "terminal.integrated.fontFamily" = "JetBrainsMono Nerd Font";
      "workbench.colorTheme" = "Catppuccin Mocha";
      "editor.semanticHighlighting.enabled" = true;
      "terminal.integrated.defaultProfile.linux" = "zsh"; # Já usando seu Zsh de elite
      "window.titleBarStyle" = "custom";
      "nix.enableLanguageServer" = true;
      "extensions.autoUpdate" = false;
      "nix.serverPath" = "nil"; # Servidor de linguagem para Nix
    };  
  };
}
