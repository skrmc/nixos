{
  pkgs,
  fonts,
  colors,
  ...
}:
{
  imports = [
    ./wayland
    # ./xsession
  ];

  home.packages = with pkgs; [
    brightnessctl
    playerctl
  ];
  xdg.dataFile = {
    "sounds/detach.wav".source = ./assets/sounds/detach.wav;
    "sounds/attach.wav".source = ./assets/sounds/attach.wav;
    "wallpapers/enanan.jpg".source = ./assets/wallpapers/enanan.jpg;
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

  services.polkit-gnome.enable = true;
}
