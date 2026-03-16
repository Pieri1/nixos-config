{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mainMod" = "SUPER";
      bind = [
        "$mainMod, Q, exec, kitty"
        "$mainMod, C, killactive,"
        "$mainMod, M, exit,"
        "$mainMod, E, exec, dolphin"
        "$mainMod, V, togglefloating,"
        "$mainMod, R, exec, wofi --show drun"
        "$mainMod, P, pseudo,"
        "$mainMod, J, togglesplit,"
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"
      ];

      input = {
        kb_layout = "br";
        kb_variant = "";
        kb_model = "pc105";
        follow_mouse = 1;
        touchpad = {
          natural_scroll = true;
        };
      };

      general = {
        gaps_in = 6;
        gaps_out = 12;
        border_size = 2;
        "col.active_border" = "rgba(89b4faff) rgba(cba6f7ff) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        layout = "dwindle";
      };

      decoration = {
        rounding = 10;
        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1eee)";
        };
        blur  = {
          enabled = true;
          size = 5;
          passes = 2;
        };
      };

      animations = {
        enabled = true;
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      exec-once = [
        "swww init"
        "swww img ~/nixos-config/images/wallpaper1.jpg"
        "waybar"
        "mako"
      ];
    };
  };
}
