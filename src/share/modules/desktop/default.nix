{
  pkgs,
  fonts,
  user,
  ...
}:

{
  imports = [
    ./wayland
    # ./xserver
  ];

  environment.systemPackages = with pkgs; [
    # --- Desktop ---
    mpv
    pavucontrol
    wl-clipboard
    xdg-utils
    nautilus
    kdePackages.breeze
    kdePackages.kdenlive
    google-chrome

    # --- Visuals ---
    bibata-cursors
    papirus-icon-theme
  ];

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      ibm-plex
      open-sans
      font-awesome
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-color-emoji
      nerd-fonts.fira-code
    ];

    fontconfig = {
      defaultFonts = {
        serif = [
          fonts.serif
          "Noto Serif"
        ];
        sansSerif = [
          fonts.sans
          "Noto Sans"
        ];
        monospace = [
          fonts.mono
          "Noto Sans Mono"
        ];
      };
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gnome
      # xdg-desktop-portal-hyprland
    ];
    config.common.default = [
      "gnome"
      # "hyprland"
    ];
  };

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

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    QT_QPA_PLATFORM = "wayland";

    # GTK_IM_MODULE = "fcitx";
    # QT_IM_MODULE = "fcitx";
    # XMODIFIERS = "@im=fcitx";
  };

  home-manager.users.${user} = {
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
  };
}
