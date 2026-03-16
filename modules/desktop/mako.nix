{ config, pkgs, ... }:

{
  services.mako = {
    enable = true;
    backgroundColor = "#1e1e2eff";
    borderColor = "#89b4faff";
    borderRadius = 8;
    borderSize = 2;
    textColor = "#cdd6f4ff";
    defaultTimeout = 5000;
  };
}
