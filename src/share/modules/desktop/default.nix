{
  lib,
  pkgs,
  user,
  ...
}:

let
  xdgPortalConfig = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
    config.common.default = [ "gtk" ];
  };
in
{
  imports = [
    ./wayland
    # ./xserver
    ./flatpak.nix
  ];

  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5 = {
      waylandFrontend = true;
      addons = with pkgs; [
        qt6Packages.fcitx5-chinese-addons
        fcitx5-pinyin-moegirl
        fcitx5-pinyin-zhwiki
      ];
      # ignoreUserConfig = true;
      settings = {
        addons = {
          pinyin.globalSection = {
            CloudPinyinEnabled = "True";
            CloudPinyinIndex = 2;
          };
          cloudpinyin.globalSection = {
            Backend = "Google";
          };
        };
        globalOptions = {
          "Hotkey/TriggerKeys" = {
            "0" = "Super+space";
          };
        };
        inputMethod = {
          GroupOrder."0" = "Default";
          "Groups/0" = {
            Name = "Default";
            DefaultIM = "keyboard-us";
          };
          "Groups/0/Items/0".Name = "keyboard-us";
          "Groups/0/Items/1".Name = "pinyin";
        };
      };
    };
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  security.polkit.enable = true;
  security.rtkit.enable = true;

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  programs = {
    dconf.enable = true;
    nautilus-open-any-terminal = {
      enable = true;
      terminal = "foot";
    };
    obs-studio = {
      enable = true;
      enableVirtualCamera = true;
      plugins = with pkgs.obs-studio-plugins; [
        obs-vaapi
        obs-backgroundremoval
        obs-pipewire-audio-capture
      ];
    };
  };

  xdg.portal = xdgPortalConfig;

  home-manager.users.${user} = {
    xdg.portal = xdgPortalConfig;

    home.packages = with pkgs; [
      brightnessctl
      playerctl
      xdg-utils

      nautilus
      pavucontrol
      kdePackages.breeze
      kdePackages.kdenlive
      blender
      gimp3
      prismlauncher
      google-chrome
      moonlight-qt
      mpv
      localsend
      scrcpy
      spice-gtk
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
}
