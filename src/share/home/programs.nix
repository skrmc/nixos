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
    slurp
    grim
  ];
  programs = {
    bash.enable = true;
    fish.enable = true;
    quickshell.enable = true;
    btop = {
      enable = true;
      settings = {
        theme_background = false;
      };
    };
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
    yazi = {
      enable = true;
      shellWrapperName = "y";
      enableBashIntegration = true;
      enableFishIntegration = true;
    };
  };
  services.cliphist = {
    enable = true;
    allowImages = true;
  };
}
