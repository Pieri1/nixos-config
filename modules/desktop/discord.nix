{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    vesktop
  ];

  home.sessionVariables = {
    NIXOS_OZONE_PLATFORM_HINT = "auto";
  };
}
