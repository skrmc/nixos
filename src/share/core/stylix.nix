{ pkgs, ... }:

{
  stylix = {
    enable = true;
    autoEnable = false;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;
    };

    fonts = {
      serif = {
        package = pkgs.ibm-plex;
        name = "IBM Plex Serif";
      };
      sansSerif = {
        package = pkgs.ibm-plex;
        name = "IBM Plex Sans";
      };
      monospace = {
        package = pkgs.nerd-fonts.fira-code;
        name = "FiraCode Nerd Font";
      };
      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
      sizes = {
        desktop = 10;
        applications = 10;
        terminal = 12;
      };
    };

    icons = {
      enable = true;
      package = pkgs.papirus-icon-theme;
      light = "Papirus";
      dark = "Papirus-Dark";
    };
  };

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      ibm-plex
      noto-fonts-color-emoji
      nerd-fonts.fira-code
    ];
  };
}
