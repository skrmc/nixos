# /etc/nixos/src/share/home.nix

{
  pkgs,
  colors,
  user,
  ...
}:
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
    imports = [ ./modules/hyprland.nix ];
    wayland.windowManager.hyprland.settings.general = {
      "col.active_border" = "rgb(${colors."70"})";
      "col.inactive_border" = "rgb(${colors."30"})";
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
            width = 30;
          };
          colors = {
            background = "${colors."15"}ff";
            prompt = "${colors."98"}ff";
            placeholder = "${colors."70"}ff";
            input = "${colors."98"}ff";
            text = "${colors."98"}ff";
            match = "${colors."70"}ff";
            selection = "${colors."30"}ff";
            selection-text = "${colors."98"}ff";
            selection-match = "${colors."70"}ff";
            border = "${colors."70"}ff";
            counter = "${colors."70"}ff";
          };
          border = {
            width = 2;
            radius = 10;
          };
        };
      };
      foot = {
        enable = true;
        settings = {
          main = {
            font = "JetBrainsMono Nerd Font:size=11";
            selection-target = "both";
            initial-window-size-chars = "120x40";
            pad = "10x10";
          };
          mouse-bindings = {
            clipboard-paste = "BTN_RIGHT";
            select-extend = "none";
          };
          colors = {
            cursor = "${colors."15"} ${colors."98"}";
            foreground = colors."98";
            background = colors."15";
          };
          csd = {
            hide-when-maximized = "yes";
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
  };
}
