# /etc/nixos/src/share/home.nix

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
            background = "282a36ff";
            text = "f8f8f2ff";
            match = "8be9fdff";
            selection = "44475add";
            selection-text = "f8f8f2ff";
            selection-match = "8be9fdff";
            border = "bd93f9ff";
          };
          border = {
            width = 2;
            radius = 10;
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
  };
}
