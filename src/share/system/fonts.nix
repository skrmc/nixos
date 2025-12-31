{ pkgs, fonts, ... }:

{
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
}
