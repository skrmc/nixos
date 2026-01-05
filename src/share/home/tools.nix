{ ... }:
{
  programs = {
    bash.enable = true;
    fish.enable = true;
    btop = {
      enable = true;
      settings = {
        theme_background = false;
      };
    };
    yazi = {
      enable = true;
      shellWrapperName = "y";
      enableBashIntegration = true;
      enableFishIntegration = true;
    };
  };
}
