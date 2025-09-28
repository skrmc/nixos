# /etc/nixos/src/share/modules/hyprland.nix

{ pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    plugins = with pkgs.hyprlandPlugins; [ hyprexpo ];
    settings = {
      "$MOD" = "SUPER";
      "$TERM" = "foot";
      "$MENU" = "fuzzel";
      "$ROUND" = "8";
      "$BORDER" = "1";
      "$GAPS_IN" = "2";
      "$GAPS_OUT" = "4";
      xwayland = {
        enabled = true;
        force_zero_scaling = true;
      };
      exec-once = [
        "fcitx5"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
        "[workspace 1 silent] $MENU"
        "[workspace 10 silent] foot -e btop"
      ];
      input = {
        accel_profile = "flat";
        touchpad = {
          scroll_factor = "0.5";
          natural_scroll = true;
        };
      };
      animations = {
        animation = [
          "global, 1, 5, default"
          "specialWorkspace, 1, 6, default, slidefadevert 20%"
        ];
      };
      decoration = {
        rounding = "$ROUND";
        shadow = {
          enabled = false;
        };
      };
      general = {
        "gaps_in" = "$GAPS_IN";
        "gaps_out" = "$GAPS_OUT";
        "border_size" = "$BORDER";
        "col.active_border" = "rgb(bd93f9)";
        "col.inactive_border" = "rgba(44475aaa)";
      };
      gesture = "3, horizontal, scale: 1.5, workspace";
      bind = [
        "$MOD, RETURN, exec, $TERM"
        "$MOD, D, exec, bash -c \"pgrep -x $MENU && pkill -x $MENU || $MENU\""
        "$MOD, E, exec, $TERM -e yazi"
        "$MOD, Q, killactive"
        "$MOD, F, togglefloating"
        # "$MOD, P, pseudo"
        # "$MOD, J, togglesplit"
        "$MOD, LEFT, movefocus, l"
        "$MOD, RIGHT, movefocus, r"
        "$MOD, UP, movefocus, u"
        "$MOD, DOWN, movefocus, d"
        "$MOD SHIFT, LEFT, movewindow, l"
        "$MOD SHIFT, RIGHT, movewindow, r"
        "$MOD SHIFT, UP, movewindow, u"
        "$MOD SHIFT, DOWN, movewindow, d"
        "$MOD, O, hyprexpo:expo, toggle"
        "$MOD, 1, workspace, 1"
        "$MOD, 2, workspace, 2"
        "$MOD, 3, workspace, 3"
        "$MOD, 4, workspace, 4"
        "$MOD, 5, workspace, 5"
        "$MOD, 6, workspace, 6"
        "$MOD, 7, workspace, 7"
        "$MOD, 8, workspace, 8"
        "$MOD, 9, workspace, 9"
        "$MOD, 0, workspace, 10"
        "$MOD SHIFT, 1, movetoworkspace, 1"
        "$MOD SHIFT, 2, movetoworkspace, 2"
        "$MOD SHIFT, 3, movetoworkspace, 3"
        "$MOD SHIFT, 4, movetoworkspace, 4"
        "$MOD SHIFT, 5, movetoworkspace, 5"
        "$MOD SHIFT, 6, movetoworkspace, 6"
        "$MOD SHIFT, 7, movetoworkspace, 7"
        "$MOD SHIFT, 8, movetoworkspace, 8"
        "$MOD SHIFT, 9, movetoworkspace, 9"
        "$MOD SHIFT, 0, movetoworkspace, 10"
        "$MOD CTRL, LEFT, workspace, -1"
        "$MOD CTRL, RIGHT, workspace, +1"
        "$MOD SHIFT, LEFT, movetoworkspace, -1"
        "$MOD SHIFT, RIGHT, movetoworkspace, +1"
        "$MOD, TAB, togglespecialworkspace, scratch"
        "$MOD SHIFT, TAB, movetoworkspace, special:scratch"
        "$MOD, ESCAPE, movetoworkspacesilent, special:scratch"
        "$MOD SHIFT, S, exec, grim -g \"$(slurp -d)\" - | wl-copy"
        "$MOD SHIFT, C, exec, hyprpicker -a"
        "$MOD, V, exec, cliphist list | $MENU --dmenu | cliphist decode | wl-copy"
      ];
      bindm = [
        "$MOD, mouse:272, movewindow"
        "$MOD, mouse:273, resizewindow"
        "$MOD, Z, movewindow"
      ];
      bindl = [
        ", XF86AudioMute, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 0%"
        "$MOD+SHIFT, M, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 0%"
        ", Print, exec, grim - | wl-copy"
        "$MOD+SHIFT, B, exec, playerctl previous"
        "$MOD+SHIFT, P, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        "$MOD+SHIFT, L, exec, systemctl suspend"
      ];
      bindle = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86MonBrightnessUp, exec, brightnessctl s +5%"
        ", XF86MonBrightnessDown, exec, brightnessctl s 5%-"
      ];
      binde = [
        "$MOD, MINUS, splitratio, -0.1"
        "$MOD, EQUAL, splitratio, 0.1"
      ];
      workspace = [
        "w[tv1], gapsout:0, gapsin:0"
        "f[1], gapsout:0, gapsin:0"
        "s[1], gapsout:$GAPS_OUT, gapsin:$GAPS_IN"
      ];
      windowrule = [
        "noblur, title:^(.*)$"
        "float, title:^(Open File)(.*)$"
        "float, title:^(Save File)(.*)$"
        "bordersize 0, floating:0, onworkspace:w[tv1]"
        "rounding 0, floating:0, onworkspace:w[tv1]"
        "bordersize 0, floating:0, onworkspace:f[1]"
        "rounding 0, floating:0, onworkspace:f[1]"
        "rounding $ROUND, onworkspace:s[1]"
        "opacity 0.8, floating:1, focus:0"
      ];
      layerrule = [
        "noanim, selection"
      ];
      misc = {
        disable_hyprland_logo = true;
        background_color = "0x000000";
        # background_color = "0x282a36";
      };
      plugin = {
        hyprexpo = {
          gap_size = 0;
          workspace_method = "first 1";
          enable_gesture = true;
          gesture_fingers = 3;
          gesture_positive = false;
        };
      };
    };
  };
}
