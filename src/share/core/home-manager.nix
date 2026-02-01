{
  user,
  ...
}:

{
  home-manager.users.${user}.home.stateVersion = "25.05";
  home-manager.users.root.home.stateVersion = "25.05";

  home-manager.sharedModules = [
    {
      stylix = {
        autoEnable = true;
        targets = {
          vscode.enable = false;
          blender.enable = false;
        };
      };
    }
    {
      home.sessionVariables = {
        EDITOR = "hx";
        VISUAL = "hx";
      };

      programs = {
        helix = {
          enable = true;
          settings = {
            editor.true-color = true;
            editor.lsp.display-inlay-hints = true;
            editor.clipboard-provider = "termcode";
            editor.cursor-shape.insert = "underline";
          };
        };
        btop = {
          enable = true;
          settings.theme_background = false;
        };
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
  ];
}
