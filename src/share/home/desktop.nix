{ pkgs, fonts, ... }:
{
  home.pointerCursor = {
    gtk.enable = true;
    # x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
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
    configFile = {
      "quickshell" = {
        force = true;
        recursive = true;
        source = ./quickshell;
      };
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
}
