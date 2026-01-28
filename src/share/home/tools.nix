{ colors, pkgs, ... }:

{
  home.sessionVariables = {
    EDITOR = "hx";
    VISUAL = "hx";
  };

  programs.helix = {
    enable = true;
    settings = {
      theme = "sakura";
      editor.clipboard-provider = "termcode";
    };
    themes.sakura = {
      inherits = "rose_pine_moon";
      palette.base = "#${colors."15"}";
      palette.surface = "#${colors."20"}";
      palette.overlay = "#${colors."25"}";
    };
  };

  programs.btop = {
    enable = true;
    settings.theme_background = false;
  };

  programs = {
    bash.enable = true;
    fish.enable = true;
    yazi = {
      enable = true;
      shellWrapperName = "y";
      enableBashIntegration = true;
      enableFishIntegration = true;
    };
  };
}
