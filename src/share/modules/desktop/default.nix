{
  inputs,
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

  security.polkit.enable = true;
  security.rtkit.enable = true;

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
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
    steam.enable = true;
  };

  xdg.portal = xdgPortalConfig;

  home-manager.users.${user} = {
    imports = [ inputs.xremap.homeManagerModules.default ];

    services.xremap = {
      enable = true;
      mouse = true;
      watch = true;

      yamlConfig = ''
        modmap:
          - name: Push to Talk
            remap:
              BTN_EXTRA:
                skip_key_event: true
                press: &ptt_press
                  - launch: ["${pkgs.wireplumber}/bin/wpctl", "set-mute", "@DEFAULT_AUDIO_SOURCE@", "0"]
                  - launch: ["${pkgs.pipewire}/bin/pw-play", "/home/${user}/.local/share/sounds/attach.wav"]
                release: &ptt_release
                  - launch: ["${pkgs.wireplumber}/bin/wpctl", "set-mute", "@DEFAULT_AUDIO_SOURCE@", "1"]
                  - launch: ["${pkgs.pipewire}/bin/pw-play", "/home/${user}/.local/share/sounds/detach.wav"]

              BTN_SIDE:
                skip_key_event: true
                press: *ptt_press
                release: *ptt_release

              KEY_LEFTALT:
                press: *ptt_press
                release: *ptt_release
      '';
    };

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
      localsend
      moonlight-qt
      mpv
      prismlauncher
      scrcpy
      spice-gtk

      vscode
      obsidian
      google-chrome
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
