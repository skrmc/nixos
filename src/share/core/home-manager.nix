{
  home-manager = {
    sharedModules = [
      {
        stylix = {
          autoEnable = false;
          targets = {
            btop.enable = true;
            # fish.enable = true;
            helix.enable = true;
            yazi.enable = true;
          };
        };

        home.sessionVariables = {
          EDITOR = "hx";
          VISUAL = "hx";
        };

        programs = {
          helix = {
            enable = true;
            settings = {
              # editor.true-color = true;
              # editor.cursor-shape.insert = "bar";
              editor.lsp.display-inlay-hints = true;
              editor.clipboard-provider = "termcode";
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
  };
}
