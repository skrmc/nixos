{ pkgs, user, ... }:

{
  home-manager.users.${user} = {
    home = {
      stateVersion = "25.05";
      packages = with pkgs; [
        brightnessctl
        hyprpicker
        playerctl
        slurp
        grim
      ];
    };
    xdg.desktopEntries = {
      btop = {
        name = "Btop";
        noDisplay = true;
      };
      fish = {
        name = "Fish";
        noDisplay = true;
      };
    };
    programs = {
      btop = {
        enable = true;
        settings = {
          color_theme = "dracula";
          theme_background = false;
        };
      };
      fuzzel = {
        enable = true;
        settings = {
          main = {
            font = "IBM Plex Sans:size=12";
            icon-theme = "Papirus";
            horizontal-pad = 20;
            vertical-pad = 15;
            width = 20;
          };
          colors = {
            background = "282a36dd";
            text = "f8f8f2ff";
            match = "8be9fdff";
            selection = "44475add";
            selection-text = "f8f8f2ff";
            selection-match = "8be9fdff";
            border = "bd93f966";
          };
          border = {
            width = 5;
            radius = 15;
          };
        };
      };
    };
    services.cliphist = {
      enable = true;
      allowImages = true;
    };
    gtk = {
      enable = true;
      theme = {
        name = "dracula";
        package = pkgs.dracula-theme;
      };
      iconTheme = {
        name = "Papirus";
      };
      font = {
        name = "IBM Plex Sans";
        size = 10;
      };
    };
    home.pointerCursor = {
      gtk.enable = true;
      # x11.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 16;
    };
    wayland.windowManager.sway = {
      enable = true;
      xwayland = true;
      checkConfig = true;
      config =
        let
          modifier = "Mod4";
          terminal = "foot";
          menu = "fuzzel";
        in
        {
          gaps = {
            inner = 2;
            outer = 4;
            smartGaps = true;
          };

          window = {
            border = 0;
            titlebar = false;
          };

          bars = [
            {
              mode = "invisible";
              position = "top";
            }
          ];

          floating.modifier = modifier;

          keybindings = {
            "${modifier}+Return" = "exec ${terminal}";
            "${modifier}+d" = "exec bash -c 'pgrep -x ${menu} && pkill -x ${menu} || ${menu}'";
            "${modifier}+e" = "exec ${terminal} -e yazi";

            "${modifier}+q" = "kill";
            "${modifier}+f" = "floating toggle";

            "${modifier}+Left" = "focus left";
            "${modifier}+Right" = "focus right";
            "${modifier}+Up" = "focus up";
            "${modifier}+Down" = "focus down";

            "${modifier}+Shift+Left" = "move left";
            "${modifier}+Shift+Right" = "move right";
            "${modifier}+Shift+Up" = "move up";
            "${modifier}+Shift+Down" = "move down";

            "${modifier}+1" = "workspace number 1";
            "${modifier}+2" = "workspace number 2";
            "${modifier}+3" = "workspace number 3";
            "${modifier}+4" = "workspace number 4";
            "${modifier}+5" = "workspace number 5";
            "${modifier}+6" = "workspace number 6";
            "${modifier}+7" = "workspace number 7";
            "${modifier}+8" = "workspace number 8";
            "${modifier}+9" = "workspace number 9";
            "${modifier}+0" = "workspace number 10";

            "${modifier}+Shift+1" = "move container to workspace number 1";
            "${modifier}+Shift+2" = "move container to workspace number 2";
            "${modifier}+Shift+3" = "move container to workspace number 3";
            "${modifier}+Shift+4" = "move container to workspace number 4";
            "${modifier}+Shift+5" = "move container to workspace number 5";
            "${modifier}+Shift+6" = "move container to workspace number 6";
            "${modifier}+Shift+7" = "move container to workspace number 7";
            "${modifier}+Shift+8" = "move container to workspace number 8";
            "${modifier}+Shift+9" = "move container to workspace number 9";
            "${modifier}+Shift+0" = "move container to workspace number 10";

            "${modifier}+Ctrl+Left" = "workspace prev";
            "${modifier}+Ctrl+Right" = "workspace next";
            "${modifier}+Shift+Ctrl+Left" = "move container to workspace prev";
            "${modifier}+Shift+Ctrl+Right" = "move container to workspace next";

            "${modifier}+Tab" = "scratchpad show";
            "${modifier}+Escape" = "move scratchpad";

            "XF86AudioMute" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 0%";
            "${modifier}+Shift+m" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 0%";
            "Print" = "exec grim - | wl-copy";
            "${modifier}+Shift+b" = "exec playerctl previous";
            "${modifier}+Shift+p" = "exec playerctl play-pause";
            "XF86AudioPlay" = "exec playerctl play-pause";
            "${modifier}+Shift+l" = "exec systemctl suspend";
            "XF86AudioRaiseVolume" = "exec wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+";
            "XF86AudioLowerVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
            "XF86MonBrightnessUp" = "exec brightnessctl s +5%";
            "XF86MonBrightnessDown" = "exec brightnessctl s 5%-";

            "${modifier}+minus" = "resize shrink width 10 px or 5 ppt";
            "${modifier}+equal" = "resize grow width 10 px or 5 ppt";

            "${modifier}+Shift+s" = "exec grim -g \"$(slurp -d)\" - | wl-copy";
            "${modifier}+Shift+c" = "exec hyprpicker -a";
            "${modifier}+v" = "exec cliphist list | ${menu} --dmenu | cliphist decode | wl-copy";
          };

          startup = [
            {
              command = "fcitx5";
              always = true;
            }
            {
              command = "wl-paste --type text --watch cliphist store";
              always = true;
            }
            {
              command = "wl-paste --type image --watch cliphist store";
              always = true;
            }
          ];

          window.commands = [
            {
              criteria = {
                title = "^(Open File)(.*)$";
              };
              command = "floating enable";
            }
            {
              criteria = {
                title = "^(Save File)(.*)$";
              };
              command = "floating enable";
            }
          ];
        };
    };
  };
}
