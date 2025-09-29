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
      # cmp = {
      #   autoLoad = true;
      #   autoEnableSources = true;
      #   settings = {
      #     sources = [
      #       { name = "nvim_lsp"; }
      #       { name = "path"; }
      #       { name = "buffer"; }
      #     ];
      #     settings = {
      #       mapping = {
      #         "<C-Space>" = "cmp.mapping.complete()";
      #         "<C-d>" = "cmp.mapping.scroll_docs(-4)";
      #         "<C-e>" = "cmp.mapping.close()";
      #         "<C-f>" = "cmp.mapping.scroll_docs(4)";
      #         "<CR>" = "cmp.mapping.confirm({ select = true })";
      #         "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
      #         "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
      #       };
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
          ts_ls.enable = true; # TS/JS
          cssls.enable = true; # CSS
          tailwindcss.enable = true; # TailwindCSS
          html.enable = true; # HTML
          svelte.enable = false; # Svelte
          vuels.enable = false; # Vue
          pyright.enable = true; # Python
          marksman.enable = true; # Markdown
          nil_ls.enable = true; # Nix
          dockerls.enable = true; # Docker
          bashls.enable = true; # Bash
          clangd.enable = true; # C/C++
          yamlls.enable = true; # YAML
          rust_analyzer = {
            enable = true;
            installRustc = true;
            installCargo = true;
          };
        };
      };
    };
  };
}
