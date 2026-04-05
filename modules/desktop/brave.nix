{ config, pkgs, ... }:

{
  programs.brave = {
    enable = true;
    package = pkgs.brave.override {
      commandLineArgs = [
        "--ozone-platform-hint=auto"
        "--ozone-platform=wayland"
        "--gtk-version=4"
        "--enable-features=UseOzonePlatform"
        "--ignore-gpu-blocklist"
        "--enable-gpu-rasterization"
        "--enable-zero-copy"
        "--force-dark-mode"
        "--enable-features=WebUIDarkMode"
      ];
    };
  };

  home.sessionVariables = {
    DEFAULT_BROWSER = "${pkgs.brave}/bin/brave";
    BROWSER = "${pkgs.brave}/bin/brave";
  };
}
