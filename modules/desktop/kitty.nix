{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    theme = "Catppuccin-Mocha";
    settings = {
      confirm_os_window_close = 0;
      background_opacity = "0.85";
      window_padding_width = 10;
      scrollback_lines = 10000;
    };
    font = {
      name = "monospace";
      size = 12;
    };
  };
}
