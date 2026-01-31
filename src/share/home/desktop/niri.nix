{
  pkgs,
  colors,
  ...
}:
{
  home.packages = with pkgs; [
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
}
