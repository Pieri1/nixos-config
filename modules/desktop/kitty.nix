{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    settings = {
      confirm_os_window_close = 0;
      background_opacity = "0.9";
      scrollback_lines = 10000;
    };
    font = {
      name = "monospace";
      size = 12;
    };
  };
};
