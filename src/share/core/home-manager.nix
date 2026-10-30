{ pkgs, user, ... }:
{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
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
          EDITOR = "nano";
          VISUAL = "nano";
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
          fish = {
            enable = true;
            shellAliases = {
              ls = "ls --color=auto";
              ll = "ls --color=auto -lha";
              bld = "nh os switch";
              cln = "nh clean all";
            };
          };
          direnv = {
            enable = true;
            enableBashIntegration = true;
            enableFishIntegration = true;
            nix-direnv.enable = true;
          };
          zoxide = {
            enable = true;
            enableBashIntegration = true;
            enableFishIntegration = true;
          };
          git = {
            enable = true;
            settings = {
              core.pager = "cat";
              init.defaultBranch = "main";
              push.autoSetupRemote = true;
              pull.rebase = true;
            };
          };
          tmux = {
            enable = true;
            escapeTime = 0;
            historyLimit = 10000;
            terminal = "tmux-256color";
            mouse = true;
            extraConfig = ''
              set -g renumber-windows on
              set -g set-clipboard on
            '';
          };
          fzf.enable = true;
          yazi = {
            enable = true;
            shellWrapperName = "y";
            enableBashIntegration = true;
            enableFishIntegration = true;
          };
        };
      }
    ];

    users.${user} = {
      home.packages = with pkgs; [
        aria2
        ffmpeg
        gh
        imagemagick
        nixfmt
        poppler-utils
        rclone
      ];

      programs.git.settings.user = {
        name = "Yejia Zhang";
        email = "Yejia995@gmail.com";
      };
    };
  };
}
