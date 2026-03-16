{
  lib,
  user,
  pkgs,
  ...
}:
{
  xdg.portal = {
    extraPortals = lib.mkForce [ pkgs.xdg-desktop-portal-gnome ];
    config.common.default = lib.mkForce [ "gnome" ];
  };

  home-manager.users.${user} = {
    home.packages = with pkgs; [
      niri
      swaybg
      xwayland-satellite
    ];

    xdg.configFile."niri" = {
      force = true;
      recursive = true;
      source = ../config/niri;
    };
  };
}
