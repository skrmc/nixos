{
  user,
  pkgs,
  ...
}:
let
  MOD = "SUPER";
  TERM = "foot";
  MENU = "fuzzel";
  FILE = "nautilus";
  BORDER = "1";
  GAPS_IN = "2";
  GAPS_OUT = "4";
  ROUNDING = "8";
in
{
  home-manager.users.${user} = {
    home.packages = with pkgs; [
      hyprpicker
      hyprsunset

      satty
      slurp
      grim
    ];

    programs.quickshell.enable = true;
    xdg.configFile = {
      "quickshell" = {
        force = true;
        recursive = true;
        source = ../config/quickshell;
      };
    };

    # v0.53.1
    wayland.windowManager.hyprland = {
      enable = true;
      # plugins = with pkgs.hyprlandPlugins; [ hyprexpo ];
      settings = {
        xwayland = {
          enabled = true;
          force_zero_scaling = true;
        };
        exec-once = [
          "fcitx5"
          "quickshell"
          "[workspace 1 silent] ${MENU}"
          "[workspace 10 silent; tile] foot -e btop"
          # "find $HOME/.local/share/wallpapers -maxdepth 1 -type f -print | head -n1 | xargs -r swaybg -m fill -i"
        ];
        input = {
          accel_profile = "flat";
          touchpad = {
            scroll_factor = "0.5";
            natural_scroll = true;
          };
        };
        animations = {
          bezier = [
            "bounce, 0.4, 1.2, 0.2, 1"
          ];
          animation = [
            "global, 1, 3, default"
            "workspaces, 1, 3, bounce, slide"
            "specialWorkspace, 1, 3, bounce, slidevert"
            "windowsIn, 1, 3, bounce, popin 60%"
            "windowsMove, 1, 3, bounce, slide"
          ];
        };
        decoration = {
          blur = {
            enabled = false;
            # xray = true;
            passes = 2;
            size = 6;
          };
          shadow.enabled = false;
          rounding = "${ROUNDING}";
          inactive_opacity = "0.95";
        };
        general = {
          "allow_tearing" = true;
          "gaps_in" = "${GAPS_IN}";
          "gaps_out" = "${GAPS_OUT}";
          "border_size" = "${BORDER}";
        };
        gesture = "3, horizontal, scale: 1.5, workspace";
        binds = {
          scroll_event_delay = 50;
          # disable_keybind_grabbing = true;
        };
        bind = [
          "${MOD}, RETURN, exec, ${TERM}"
          "${MOD}, E, exec, ${FILE}"
          "${MOD}, Q, killactive"
          "${MOD}, C, centerwindow"
          "${MOD}, W, togglefloating"
          "${MOD}, F, fullscreenstate, 2 0"
          "${MOD} SHIFT, F, fullscreenstate, 0 2"
          "${MOD}, D, exec, pkill ${MENU} || ${MENU}"
          "${MOD}, J, togglesplit"
          "${MOD}, P, pin"
          "${MOD}, M, exit"
          "${MOD}, UP, movefocus, u"
          "${MOD}, DOWN, movefocus, d"
          "${MOD}, LEFT, movefocus, l"
          "${MOD}, RIGHT, movefocus, r"
          "${MOD} SHIFT, LEFT, movewindow, l"
          "${MOD} SHIFT, RIGHT, movewindow, r"
          "${MOD} SHIFT, UP, movewindow, u"
          "${MOD} SHIFT, DOWN, movewindow, d"
          # "${MOD}, O, hyprexpo:expo, toggle"
          "${MOD}, 1, workspace, 1"
          "${MOD}, 2, workspace, 2"
          "${MOD}, 3, workspace, 3"
          "${MOD}, 4, workspace, 4"
          "${MOD}, 5, workspace, 5"
          "${MOD}, 6, workspace, 6"
          "${MOD}, 7, workspace, 7"
          "${MOD}, 8, workspace, 8"
          "${MOD}, 9, workspace, 9"
          "${MOD}, 0, workspace, 10"
          "${MOD}, LEFT, workspace, -1"
          "${MOD}, RIGHT, workspace, +1"
          "${MOD}, mouse_up, workspace, +1"
          "${MOD}, mouse_down, workspace, -1"

          "${MOD} SHIFT, 1, movetoworkspace, 1"
          "${MOD} SHIFT, 2, movetoworkspace, 2"
          "${MOD} SHIFT, 3, movetoworkspace, 3"
          "${MOD} SHIFT, 4, movetoworkspace, 4"
          "${MOD} SHIFT, 5, movetoworkspace, 5"
          "${MOD} SHIFT, 6, movetoworkspace, 6"
          "${MOD} SHIFT, 7, movetoworkspace, 7"
          "${MOD} SHIFT, 8, movetoworkspace, 8"
          "${MOD} SHIFT, 9, movetoworkspace, 9"
          "${MOD} SHIFT, 0, movetoworkspace, 10"
          "${MOD} SHIFT, LEFT, movetoworkspace, -1"
          "${MOD} SHIFT, RIGHT, movetoworkspace, +1"
          "${MOD} SHIFT, mouse_up, movetoworkspace, +1"
          "${MOD} SHIFT, mouse_down, movetoworkspace, -1"

          "${MOD}, TAB, togglespecialworkspace, tab"
          "${MOD} SHIFT, TAB, movetoworkspace, special:tab"
          "${MOD}, ESCAPE, movetoworkspacesilent, special:tab"

          "${MOD} SHIFT, S, exec, grim -g \"$(slurp -d)\" - | wl-copy"
          "${MOD} SHIFT, C, exec, hyprpicker -a"
          "${MOD}, V, exec, cliphist list | ${MENU} --dmenu | cliphist decode | wl-copy"
        ];
        # bindr = [
        #   "${MOD}, ${MOD}_L, exec, pkill ${MENU} || ${MENU}"
        # ];
        bindm = [
          "${MOD}, mouse:272, movewindow"
          "${MOD}, mouse:273, resizewindow"
          "${MOD}, Z, movewindow"
        ];
        bindl = [
          ", XF86AudioMute, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 0%"
          "${MOD}+SHIFT, M, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 0%"
          ", Print, exec, grim - | wl-copy"
          "${MOD}+SHIFT, B, exec, playerctl previous"
          "${MOD}+SHIFT, P, exec, playerctl play-pause"
          ", XF86AudioPlay, exec, playerctl play-pause"
          "${MOD}+SHIFT, L, exec, systemctl suspend"
        ];
        bindle = [
          ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 2%+"
          ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-"
          ", XF86MonBrightnessUp, exec, brightnessctl s +5%"
          ", XF86MonBrightnessDown, exec, brightnessctl s 5%-"
        ];
        binde = [
          "${MOD}, MINUS, splitratio, -0.1"
          "${MOD}, EQUAL, splitratio, 0.1"
        ];
        layerrule = [
          "match:namespace selection, no_anim on"
          "match:namespace (quickshell)(.*), no_anim on"
        ];
        windowrule = [
          "match:title .*File.*, float on"
          "match:fullscreen [^0], immediate on"
          "match:class ${TERM}, float on, center on"
          "match:float true, match:focus false, opacity 0.75"
          "match:float 0, match:workspace w[tv1]s[0], rounding 0"
          "match:float 0, match:workspace w[tv1]s[0], border_size 0"
        ];
        workspace = [
          "w[tv1]s[0], gapsout:0, gapsin:0"
          "f[1]s[0], gapsout:0, gapsin:0"
        ];
        misc = {
          enable_swallow = true;
          swallow_regex = "${TERM}";
          disable_hyprland_logo = true;
        };
        # plugin = {
        #   hyprexpo = {
        #     gap_size = 0;
        #     workspace_method = "first 1";
        #     enable_gesture = true;
        #     gesture_fingers = 3;
        #     gesture_positive = false;
        #   };
        # };
      };
    };
  };
}
