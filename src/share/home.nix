# /etc/nixos/src/share/home.nix

{
  lib,
  pkgs,
  colors,
  user,
  ...
}:
let
  hexify =
    {
      hex,
      alpha ? null,
    }:
    let
      base = lib.strings.removePrefix "#" hex;
    in
    if alpha == null then base else "${base}${alpha}";
in
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
            background = hexify {
              hex = colors."15";
              alpha = "ff";
            };
            text = hexify {
              hex = colors."98";
              alpha = "ff";
            };
            match = hexify {
              hex = colors."70";
              alpha = "ff";
            };
            selection = hexify {
              hex = colors."30";
              alpha = "dd";
            };
            selection-text = hexify {
              hex = colors."98";
              alpha = "ff";
            };
            selection-match = hexify {
              hex = colors."70";
              alpha = "ff";
            };
            border = hexify {
              hex = colors."80";
              alpha = "ff";
            };
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
          color = {
            cursor = "${hexify { hex = colors."15"; }} ${hexify { hex = colors."98"; }}";
            foreground = hexify { hex = colors."98"; };
            background = hexify { hex = colors."15"; };
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
