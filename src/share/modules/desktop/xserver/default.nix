{
  config,
  lib,
  pkgs,
  user,
  ...
}:
let
  cfg = config.desktop;
in
{
  config = lib.mkIf (cfg == "xserver") {
    services.xserver = {
      enable = true;
      displayManager.startx = {
        enable = true;
        generateScript = true;
      };
      windowManager.i3.enable = true;
    };

    environment = {
      sessionVariables.TERMINAL = "alacritty";
      systemPackages = with pkgs; [
        arandr
        xclip
        xev
        xkill
        xrandr
      ];
    };

    programs.nautilus-open-any-terminal.terminal = lib.mkForce "alacritty";

    home-manager.users.${user} = {
      xsession = {
        enable = true;
        windowManager.i3 = {
          enable = true;
          config = {
            modifier = "Mod4";
            terminal = "alacritty";
            menu = "dmenu_run -i";
            keybindings = lib.mkOptionDefault {
              "Mod4+space" = null;
              "Mod4+q" = "kill";
              "Mod4+v" = "exec --no-startup-id ${pkgs.clipmenu}/bin/clipmenu -i";
            };
            window.titlebar = false;
            floating.titlebar = false;
            bars = [
              {
                statusCommand = "${pkgs.i3status}/bin/i3status";
              }
            ];
            defaultWorkspace = "workspace number 1";
          };
        };
      };

      services.clipmenu = {
        enable = true;
        launcher = "${pkgs.dmenu}/bin/dmenu";
      };

      stylix.targets = {
        alacritty.enable = true;
        i3.enable = true;
        xresources.enable = true;
      };

      programs = {
        alacritty = {
          enable = true;
          settings = {
            window.padding = {
              x = 10;
              y = 10;
            };
            selection.save_to_clipboard = true;
            mouse.bindings = [
              {
                mouse = "Right";
                action = "Paste";
              }
            ];
          };
        };
        i3status.enable = true;
      };
    };
  };
}
