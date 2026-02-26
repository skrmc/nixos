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
    ./i18n
    ./wayland
    # ./xserver
    ./flatpak.nix
  ];

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
              KEY_F24:
                skip_key_event: true
                press: &ptt_press
                  - launch: ["${pkgs.wireplumber}/bin/wpctl", "set-mute", "@DEFAULT_AUDIO_SOURCE@", "0"]
                  - launch: ["${pkgs.pipewire}/bin/pw-play", "/home/${user}/.local/share/sounds/attach.wav"]
                release: &ptt_release
                  - launch: ["${pkgs.wireplumber}/bin/wpctl", "set-mute", "@DEFAULT_AUDIO_SOURCE@", "1"]
                  - launch: ["${pkgs.pipewire}/bin/pw-play", "/home/${user}/.local/share/sounds/detach.wav"]

              KEY_LEFTALT:
                press: *ptt_press
                release: *ptt_release
      '';
    };

    xdg.portal = xdgPortalConfig;

    stylix.targets = {
      gtk.enable = true;
      qt.enable = true;
    };

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
      foliate

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
