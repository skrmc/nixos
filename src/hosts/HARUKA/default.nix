{
  pkgs,
  user,
  ...
}:
let
  dpi = 168;
in
{
  networking.hostName = "HARUKA";
  system.stateVersion = "25.11";

  profiles = {
    personal.enable = true;
    laptop.enable = true;
    rust.enable = true;
  };
  desktop = "xserver";
  hardware.graphics.enable = true;
  services = {
    spice-vdagentd.enable = true;
    xserver = {
      inherit dpi;
      inputClassSections = [
        ''
          Identifier "libinput horizontal scrolling disabled"
          MatchDriver "libinput"
          Option "HorizontalScrolling" "off"
        ''
      ];
    };
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
  imports = [
    ./hardware-configuration.nix
  ];
}
