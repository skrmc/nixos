{ pkgs, fonts, ... }:

{
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      ibm-plex
      fira-code
      font-awesome
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-color-emoji
      nerd-fonts.symbols-only
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
