{ pkgs, fonts, ... }:

{
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
}
