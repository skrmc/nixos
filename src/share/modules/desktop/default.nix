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
  imports = [
    ./wayland
    ./xserver
    ./i18n.nix
  ];

  options.desktop = lib.mkOption {
    type = lib.types.nullOr (
      lib.types.enum [
        "xserver"
        "wayland"
      ]
    );
    default = null;
    description = "Desktop session type to configure.";
  };

  config = lib.mkIf (cfg != null) {
    security.rtkit.enable = true;

    hardware.bluetooth.enable = true;

    services = {
      blueman.enable = true;
      flatpak.enable = true;
      gvfs.enable = true;
      pipewire = {
        enable = true;
        alsa.enable = true;
        pulse.enable = true;
      };
      udisks2.enable = true;
    };

    programs = {
      appimage = {
        enable = true;
        binfmt = true;
      };
      nautilus-open-any-terminal.enable = true;
      obs-studio = {
        enable = true;
        enableVirtualCamera = true;
        plugins = with pkgs.obs-studio-plugins; [
          wlrobs
          obs-vaapi
          obs-pipewire-audio-capture
        ];
      };
    };

    home-manager.users.${user} = {
      stylix.targets.gtk.enable = true;
      # stylix.targets.qt.enable = true;

      home.packages = with pkgs; [
        brightnessctl
        playerctl
        xdg-utils

        nautilus
        pavucontrol
        localsend
        spice-gtk
        foliate

        google-chrome
        obsidian
        vscode
      ];

      xdg = {
        dataFile = {
          "sounds/detach.wav".source = ./assets/sounds/detach.wav;
          "sounds/attach.wav".source = ./assets/sounds/attach.wav;
          "wallpapers/enanan.jpg".source = ./assets/wallpapers/enanan.jpg;
        };
        userDirs = {
          enable = true;
          createDirectories = true;
        };
      };
    };
  };
}
