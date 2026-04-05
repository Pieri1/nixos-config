{ pkgs, ... }:

{
  stylix.enable = true;

  # Use UMA abordagem:
  # 1) Tema por wallpaper:
  # stylix.image = ./images/wallpaper/wallpaper.png;

  # 2) Tema fixo base16:
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/oxocarbon-dark.yaml";

  # Lista pronta (Ctrl+C / Ctrl+V):
  # stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/oxocarbon-dark.yaml";
  # stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/dracula.yaml";
  # stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
  # stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";
  # stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-soft.yaml";
  # stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-light-hard.yaml";
  # stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-light-medium.yaml";
  # stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-light-soft.yaml";
  # stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
  # stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/solarized-dark.yaml";
  # stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/solarized-light.yaml";

  stylix.cursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
  };

  stylix.fonts = {
    monospace = {
      package = pkgs.nerd-fonts.jetbrains-mono;
      name = "JetBrains Mono";
    };
    sansSerif = {
      package = pkgs.noto-fonts;
      name = "Noto Sans";
    };
    serif = {
      package = pkgs.noto-fonts;
      name = "Noto Serif";
    };
  };

  stylix.targets = {
    hyprland.enable = true;
    kitty.enable = true;
    vscode.enable = true;
    vesktop.enable = true;
    waybar.enable = true;
    gtk.enable = true;
  };
}
