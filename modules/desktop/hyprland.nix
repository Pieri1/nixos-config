{ pkgs, ... }:

let
  handle_lid = pkgs.writeShellScriptBin "handle_lid" ''
    LOG_FILE="/tmp/hypr_lid_history.log"
    STATE_FILE="/tmp/hypr_lid_state"

    if [ "$1" == "close" ]; then
        echo "$(date '+%Y-%m-%d %H:%M:%S') - Evento: Tampa Fechada" >> "$LOG_FILE"
        echo "closed" > "$STATE_FILE"
        
        # Desativa o notebook e força o Workspace 1 no HDMI
        ${pkgs.hyprland}/bin/hyprctl keyword monitor "eDP-1, disable"
        ${pkgs.hyprland}/bin/hyprctl dispatch moveworkspacetomonitor 1 HDMI-A-1
        ${pkgs.hyprland}/bin/hyprctl dispatch focusmonitor HDMI-A-1
        
    elif [ "$1" == "open" ]; then
        echo "$(date '+%Y-%m-%d %H:%M:%S') - Evento: Tampa Aberta" >> "$LOG_FILE"
        echo "open" > "$STATE_FILE"
        
        # Reativa o notebook e devolve a autonomia
        ${pkgs.hyprland}/bin/hyprctl keyword monitor "eDP-1, preferred, auto, 1"
    fi
  '';

  keyboard_backlight = pkgs.writeShellScriptBin "keyboard_backlight" ''
    action="$1"
    shopt -s nullglob
    devices=(/sys/class/leds/*::scrolllock)

    if [ ''${#devices[@]} -eq 0 ]; then
      ${pkgs.libnotify}/bin/notify-send "Keyboard light" "Nenhum dispositivo *::scrolllock encontrado."
      exit 1
    fi

    first_device_name="$(basename "''${devices[0]}")"
    max="$(${pkgs.brightnessctl}/bin/brightnessctl -d "$first_device_name" max)"
    any_on=0
    for led in "''${devices[@]}"; do
      device_name="$(basename "$led")"
      current="$(${pkgs.brightnessctl}/bin/brightnessctl -d "$device_name" get)"
      if [ "$current" -gt 0 ]; then
        any_on=1
      fi
    done

    case "$action" in
      up)
        for led in "''${devices[@]}"; do
          device_name="$(basename "$led")"
          if [ "$max" -le 1 ]; then
            ${pkgs.brightnessctl}/bin/brightnessctl -d "$device_name" set 1 >/dev/null
          else
            ${pkgs.brightnessctl}/bin/brightnessctl -d "$device_name" set +1 >/dev/null
          fi
        done
        ;;
      down)
        for led in "''${devices[@]}"; do
          device_name="$(basename "$led")"
          if [ "$max" -le 1 ]; then
            ${pkgs.brightnessctl}/bin/brightnessctl -d "$device_name" set 0 >/dev/null
          else
            ${pkgs.brightnessctl}/bin/brightnessctl -d "$device_name" set 1- >/dev/null
          fi
        done
        ;;
      toggle)
        for led in "''${devices[@]}"; do
          device_name="$(basename "$led")"
          if [ "$any_on" -gt 0 ]; then
            ${pkgs.brightnessctl}/bin/brightnessctl -d "$device_name" set 0 >/dev/null
          else
            ${pkgs.brightnessctl}/bin/brightnessctl -d "$device_name" set "$max" >/dev/null
          fi
        done
        ;;
      *)
        exit 1
        ;;
    esac
  '';
  
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mainMod" = "SUPER";
      
      bind = [
        "$mainMod, Q, exec, kitty"
        "$mainMod, C, killactive,"
        "$mainMod, M, exit,"
        "$mainMod, E, exec, nautilus"
        "$mainMod, V, togglefloating,"
        "$mainMod, R, exec, wofi --show drun --allow-images --allow-markup --image-size 28"
        "$mainMod, P, pseudo,"
        "$mainMod, J, togglesplit,"
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
        ", code:78, exec, ${keyboard_backlight}/bin/keyboard_backlight up"
        ", XF86AudioMute, exec, pamixer -t"
        "$mainMod, D, togglespecialworkspace, discord"
        "$mainMod, W, togglespecialworkspace, whatsapp"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      binde = [
        ", XF86AudioRaiseVolume, exec, pamixer -i 5"
        ", XF86AudioLowerVolume, exec, pamixer -d 5"
        ", XF86MonBrightnessUp, exec, brightnessctl set 1%+"
        ", XF86MonBrightnessDown, exec, brightnessctl set 1%-"
        ", XF86KbdLightOnOff, exec, ${keyboard_backlight}/bin/keyboard_backlight up"
        ", XF86KbdBrightnessUp, exec, ${keyboard_backlight}/bin/keyboard_backlight up"
        ", XF86KbdBrightnessDown, exec, ${keyboard_backlight}/bin/keyboard_backlight down"
      ];

      # Gatilhos de Hardware (Lid Switch)
      bindl = [
        # switch:on = Tampa Fechada (State 1)
        ", switch:on:Lid Switch, exec, ${handle_lid}/bin/handle_lid close"
        # switch:off = Tampa Aberta (State 0)
        ", switch:off:Lid Switch, exec, ${handle_lid}/bin/handle_lid open"
      ];

      input = {
        kb_layout = "br";
        follow_mouse = 1;
        mouse_refocus = true;
        numlock_by_default = true;
        touchpad.natural_scroll = true;
      };

      monitor = [
        "HDMI-A-1, preferred, 0x0, 1"
        "eDP-1, preferred, auto, 1"
      ];

      workspace = [
        # Garante que o monitor HDMI seja o "foco" inicial de criação
        "monitor:HDMI-A-1, default:true"
        
        # Vincula explicitamente os fujões
        "1, monitor:HDMI-A-1, default:true"
        "2, monitor:HDMI-A-1, default:true"
        "3, monitor:HDMI-A-1"
        "4, monitor:HDMI-A-1"
        "5, monitor:HDMI-A-1"
        "6, monitor:HDMI-A-1"
        "7, monitor:HDMI-A-1"
        "8, monitor:HDMI-A-1"
        "9, monitor:HDMI-A-1"
        "10, monitor:HDMI-A-1"
      ];

      general = {
        gaps_in = 6;
        gaps_out = 12;
        border_size = 2;
        layout = "dwindle";
      };

      decoration = {
        rounding = 10;
        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
        };
        blur = {
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

      cursor = {
        no_warps = false;
        inactive_timeout = 0;
      };

      windowrulev2 = [
        # Regras de flutuação e centralização
        "float, class:(org.pulseaudio.pavucontrol)"
        "float, class:(nm-connection-editor)"
        "float, class:(waypaper)"
        "size 700 500, class:(org.pulseaudio.pavucontrol)"
        "size 600 500, class:(nm-connection-editor)"
        "size 900 600, class:(waypaper)"
        "center, class:(org.pulseaudio.pavucontrol)"
        "center, class:(nm-connection-editor)"
        "center, class:(waypaper)"

        # Vesktop (Discord) Special Workspace
        "workspace special:discord, class:(vesktop)"
        "size 80% 85%, class:(vesktop)"
        "center, class:(vesktop)"

        # WhatsApp no Special Workspace
        "workspace special:whatsapp, class:(wasistlos)"
        "size 80% 85%, class:(wasistlos)"
        "center, class:(wasistlos)"

        # Steam
        "stayfocused, title:^()$,class:^(steam)$"
        "minsize 1 1, title:^()$,class:^(steam)$"

        "opacity 0.8 0.8, class:(vesktop)"
      ];

      exec-once = [
        "swww-daemon"
        "nm-applet --indicator"
        "swaync"
        "waybar"
        "hyprctl dispatch dpms on"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
        "wl-clip-persist --clipboard regular"
      ];

      misc = {
        mouse_move_enables_dpms = true;
        key_press_enables_dpms = true;
        focus_on_activate = true;
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master = {
        new_status = "master";
        mfact = 0.5;
      };
    };
  };
}