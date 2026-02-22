{ pkgs, ... }:

{
  stylix = {
    enable = true;
    autoEnable = false;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine-dawn.yaml";

    # base16Scheme = {
    #   base00 = "#000000"; # Default background
    #   base01 = "#000000"; # Alternate background
    #   base02 = "#000000"; # Selection background
    #   base03 = "#000000"; # Muted text
    #   base04 = "#000000"; # Alternate text
    #   base05 = "#000000"; # Default text
    #   base06 = "#000000"; # Foreground (Not often used)
    #   base07 = "#000000"; # Foreground (Not often used)
    #   base08 = "#000000"; # Red (Error)
    #   base09 = "#000000"; # Orange (Urgent)
    #   base0A = "#000000"; # Yellow (Warning)
    #   base0B = "#000000"; # Green (Success)
    #   base0C = "#000000";
    #   base0D = "#000000";
    #   base0E = "#000000";
    #   base0F = "#000000";
    # };

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
