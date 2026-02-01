{
  pkgs,
  user,
  ...
}:
{
  imports = [
    ./hyprland.nix
    # ./niri.nix
  ];

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  home-manager.users.${user} = {
    home.packages = with pkgs; [
      wl-clipboard
    ];
    programs = {
      fuzzel = {
        enable = true;
        settings = {
          main = {
            horizontal-pad = 20;
            vertical-pad = 15;
            width = 30;
          };
          border = {
            width = 2;
            radius = 8;
          };
        };
      };
      foot = {
        enable = true;
        settings = {
          main = {
            pad = "20x20";
            selection-target = "both";
            initial-window-size-chars = "90x30";
          };
          cursor = {
            style = "beam";
            blink = "yes";
          };
          mouse-bindings = {
            clipboard-paste = "BTN_RIGHT";
            select-extend = "none";
          };
          csd = {
            hide-when-maximized = "yes";
          };
        };
      };
    };

    services = {
      mako = {
        enable = true;
        settings = {
          markup = true;
          actions = true;
          max-visible = 3;
          default-timeout = 0;
          border-radius = 8;
          border-size = 2;
          padding = "8,10";

          "mode=do-not-disturb" = {
            invisible = 1;
          };
        };
      };
      cliphist = {
        enable = true;
        allowImages = true;
      };
    };
  };
}
