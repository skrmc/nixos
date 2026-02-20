{ pkgs, ... }:

{
  stylix = {
    enable = true;
    autoEnable = false;
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";

    base16Scheme = {
      base00 = "#1e1818";
      base01 = "#2a2222";
      base02 = "#332929";
      base03 = "#7a6d6d";
      base04 = "#9b8a8a";
      base05 = "#f8f4f4"; # Text
      base06 = "#f8f4f4"; # Text
      base07 = "#614646"; # Highlight
      base08 = "#f0bba8";
      base09 = "#f0d8a8";
      base0A = "#f0bba8";
      base0B = "#f0d8a8";
      base0C = "#f0d8a8";
      base0D = "#f0bba8"; # Border
      base0E = "#f0d8a8";
      base0F = "#614646"; # Highlight
    };

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
