{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;

    extensions = with pkgs.vscode-extensions; [
      jnoortheen.nix-ide #Suporte para arquivos nix
      ms-vscode-remote.remote-containers
      ms-azuretools.vscode-docker
    ];

    userSettings = {
      "editor.semanticHighlighting.enabled" = true;
      "terminal.integrated.defaultProfile.linux" = "zsh";
      "window.titleBarStyle" = "custom";
      "nix.enableLanguageServer" = true;
      "extensions.autoUpdate" = false;
      "nix.serverPath" = "nil";
    };  
  };
}
