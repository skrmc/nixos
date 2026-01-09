{
  pkgs,
  fonts,
  colors,
  ...
}:
{
  home.packages = with pkgs; [
    brightnessctl
    hyprpicker
    playerctl
    # satty
    # slurp
    # grim

    niri
    swaybg
    xwayland-satellite
  ];

  xdg.configFile = {
    "niri/config.kdl".source = ./config/niri/config.kdl;
    "niri/keybinds.kdl".source = ./config/niri/keybinds.kdl;
    "niri/layout.kdl".source = pkgs.replaceVars ./config/niri/layout.in.kdl {
      error = "#${colors.error}ff";
      active = "#${colors."50"}cc";
      inactive = "#${colors."50"}44";
    };
  };

  home.pointerCursor = {
    gtk.enable = true;
    # x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
  };
  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus";
    };
    font = {
      name = fonts.sans;
      size = 10;
    };
  };
  xdg = {
    userDirs = {
      enable = true;
      createDirectories = true;
    };
    desktopEntries = {
      btop = {
        name = "Btop";
        noDisplay = true;
      };
      fish = {
        name = "Fish";
        noDisplay = true;
      };
    };
  };

  programs = {
    fuzzel = {
      enable = true;
      settings = {
        main = {
          font = "${fonts.sans}:size=13";
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
          width = 3;
          radius = 12;
        };
      };
    };
    foot = {
      enable = true;
      settings = {
        main = {
          font = "${fonts.mono}:size=12";
          selection-target = "both";
          pad = "20x20";
        };
        cursor = {
          style = "beam";
          blink = "yes";
        };
        mouse-bindings = {
          clipboard-paste = "BTN_RIGHT";
          select-extend = "none";
        };
        colors = {
          cursor = "${colors."15"} ${colors."98"}";
          foreground = colors."98";
          background = colors."15";
          /*
            Rose Pine Moon
            regular0=393552     # black (Overlay)
            regular1=eb6f92     # red (Love)
            regular2=9ccfd8     # green (Foam)
            regular3=f6c177     # yellow (Gold)
            regular4=3e8fb0     # blue (Pine)
            regular5=c4a7e7     # magenta (Iris)
            regular6=ea9a97     # cyan (Rose)
            regular7=e0def4     # white (Text)
          */
          regular0 = "393552";
          regular1 = "eb6f92";
          regular2 = "9ccfd8";
          regular3 = "f6c177";
          regular4 = "3e8fb0";
          regular5 = "c4a7e7";
          regular6 = "ea9a97";
          regular7 = "e0def4";
        };
        csd = {
          hide-when-maximized = "yes";
        };
      };
    };
  };

  services = {
    mako.enable = true;
    polkit-gnome.enable = true;
    cliphist = {
      enable = true;
      allowImages = true;
    };
  };
}
