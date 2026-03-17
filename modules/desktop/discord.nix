{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    vesktop
  ];

  home.sessionVariables = {
    NIXOS_OZONE_PLATFORM_HINT = "auto";
  };

  home.file.".config/vesktop/themes/catppuccin.css".text = ''
    @import url("https://catppuccin.github.io/discord/dist/catppuccin-mocha.theme.css");
  '';
}
