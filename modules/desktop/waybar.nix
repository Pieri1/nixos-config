{ config, pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        modules-left = [ "hyprland/workspaces" "hyprland/mode" ];
        modules-center = [ "hyprland/window" ];
        modules-right = [ "pulseaudio" "network" "cpu" "memory" "baterry" "clock" "tray" ];
        "hyprland/workspaces" = {
          format = "{icon}";
          on-click = "activate";
        };
        "clock" = {
          format = "\uf017 {:%H:%M}";
          tooltip-format = "<big>{:%Y %B}</big>/n<tt><small>{calendar}</small></tt>";
        };
        "baterry" = {
          format = "{icon} {capacity}%";
          format-icons = [ "\uf244" "\uf243" "\uf242" "\uf241" "\uf240" ];
        };
        "pulseaudio" = {
          format = "{icon} {volume}%";
          format-icons = {
            default = [ "\uf026" "\uf027" "\uf028" ];
          };
          on-click = "pabucontrol";
        };
      };
    };

    style = ''
      * {
        font-family: "JetBrainsMono Nerd Font";
        font-size: 13px;
      }
      window#waybar {
        background: rgba(30, 30, 46, 0.9);
        color: #cdd6f4;
        border-bottom: 2px solid #89b4fa
      }
      #workspaces button {
        color: #89b4fa
      }
      #workspaces button.active {
        color: #f5c2e7
      }
    '';
  };
}
