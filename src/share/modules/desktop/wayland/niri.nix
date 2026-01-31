{
  user,
  pkgs,
  ...
}:
{
  home-manager.users.${user} = {
    home.packages = with pkgs; [
      niri
      swaybg
      xwayland-satellite
    ];

    xdg.configFile = {
      "niri/config.kdl".source = ../config/niri/config.kdl;
      "niri/keybinds.kdl".source = ../config/niri/keybinds.kdl;
      "niri/layout.kdl".source = ../config/niri/layout.kdl;
    };
  };
}
