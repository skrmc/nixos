{ pkgs, ... }:

{
  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
    withNodeJs = true;
    opts = {
      number = true;
      relativenumber = true;
      tabstop = 2;
      shiftwidth = 2;
      expandtab = true;
      clipboard = "unnamedplus";
    };
    colorschemes.rose-pine = {
      enable = true;
      settings = {
        variant = "moon";
        styles.transparency = true;
      };
    };
    plugins = {
      indent-blankline = {
        enable = true;
        settings = {
          indent = {
            char = "|";
          };
        };
      };
      # avante = {
      #   enable = true;
      #   settings = {
      #     auto_suggestions_provider = "openai";
      #     provider = "openai";
      #     behaviour = {
      #       auto_suggestions = false;
      #     };
      #     openai = {
      #       endpoint = "https://chat.sakiko.work/api";
      #       model = "xai/grok-2";
      #       timeout = 30000;
      #       max_tokens = 131072;
      #     };
      #   };
      # };
      blink-cmp = {
        enable = true;
        setupLspCapabilities = true;
      };
      # Nix expressions in Neovim
      nix = {
        enable = true;
      };

      # Language server
      lsp = {
        enable = true;
        servers = {
          # rust_analyzer = {
          #   enable = true;
          #   installRustc = true;
          #   installCargo = true;
          # };
          # cssls.enable = true; # CSS
          # tailwindcss.enable = true; # TailwindCSS
          # html.enable = true; # HTML
          # svelte.enable = false; # Svelte
          # dockerls.enable = true; # Docker
          # bashls.enable = true; # Bash
          # yamlls.enable = true; # YAML
          ts_ls.enable = true; # TS/JS
          pyright.enable = true; # Python
          marksman.enable = true; # Markdown
          nil_ls.enable = true; # Nix
          clangd.enable = true; # C/C++
        };
      };
    };
  };
}
