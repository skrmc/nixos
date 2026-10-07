{ pkgs, user, ... }:
let
  dpi = 168;
in
{
  imports = [ ./hardware-configuration.nix ];

  networking.hostName = "HARUKA";
  system.stateVersion = "25.11";
  home-manager.users = {
    ${user} = {
      home.stateVersion = "26.05";
      xresources.properties."Xft.dpi" = dpi;
      xsession.windowManager.i3.config.startup = [
        {
          command = "${pkgs.procps}/bin/pgrep -u ${user} -x spice-vdagent >/dev/null || ${pkgs.spice-vdagent}/bin/spice-vdagent";
          notification = false;
        }
      ];
    };
    root.home.stateVersion = "26.05";
  };

  profiles = {
    personal.enable = true;
    development.enable = true;
    container.enable = true;
  };
  desktop = "xserver";

  hardware.graphics.enable = true;

  services = {
    spice-vdagentd.enable = true;
    xserver.dpi = dpi;
    libinput = {
      mouse = {
        naturalScrolling = true;
        horizontalScrolling = false;
      };
      touchpad = {
        naturalScrolling = true;
        horizontalScrolling = false;
      };
    };
  };
}
