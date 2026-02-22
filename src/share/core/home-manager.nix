{
  inputs,
  user,
  ...
}:

{
  home-manager.users.${user}.home.stateVersion = "25.05";
  home-manager.users.root.home.stateVersion = "25.05";

  home-manager.sharedModules = [
    inputs.nix-flatpak.homeManagerModules.nix-flatpak
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

      services.flatpak = {
        enable = true;
        overrides.global = {
          Context = {
            sockets = [ "wayland" ];
            filesystems = [ "xdg-public-share" ];
          };
          Environment = {
            ELECTRON_OZONE_PLATFORM_HINT = "wayland";
          };
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
            # editor.true-color = true;
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
