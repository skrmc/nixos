{ lib, pkgs, ... }:

{
  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
    globals.mapleader = " ";
    opts = {
      number = true;
      smartcase = true;
      ignorecase = true;
      relativenumber = true;
      clipboard = "unnamedplus";
    };
    colorschemes.rose-pine = {
      enable = true;
      settings = {
        variant = "moon";
        styles.transparency = true;
      };
    };
    keymaps = [
      # Buffer navigation
      {
        action = "<cmd>bnext<CR>";
        key = "<leader>bn";
        options.desc = "Next buffer";
      }
      {
        action = "<cmd>bprevious<CR>";
        key = "<leader>bp";
        options.desc = "Previous buffer";
      }

      # Fugitive
      {
        action = "<cmd>Git<CR>";
        key = "<leader>gg";
        options.desc = "Git status";
      }
      {
        action = "<cmd>Git blame<CR>";
        key = "<leader>gb";
        options.desc = "Git blame";
      }

      # LSP
      {
        action = "<cmd>LspInfo<CR>";
        key = "<leader>li";
        options.desc = "LSP Info";
      }
      {
        action = "<cmd>lua vim.lsp.buf.definition()<CR>";
        key = "<leader>ld";
        options.desc = "LSP Go to definition";
      }
      {
        action = "<cmd>lua vim.lsp.buf.references()<CR>";
        key = "<leader>lr";
        options.desc = "LSP Find references";
      }
      {
        action = "<cmd>lua vim.lsp.buf.rename()<CR>";
        key = "<leader>ln";
        options.desc = "LSP Rename symbol";
      }
      {
        action = "<cmd>lua vim.lsp.buf.code_action()<CR>";
        key = "<leader>la";
        mode = [
          "n"
          "x"
        ];
        options.desc = "LSP Code actions";
      }
      {
        action = "<cmd>lua vim.diagnostic.setqflist()<CR>";
        key = "<leader>le";
        options.desc = "Show all diagnostics";
      }
      {
        action = "<cmd>lua vim.diagnostic.goto_next()<CR>";
        key = "<leader>en";
        options.desc = "Next diagnostic";
      }
      {
        action = "<cmd>lua vim.diagnostic.goto_prev()<CR>";
        key = "<leader>ep";
        options.desc = "Previous diagnostic";
      }

      # File navigation
      {
        action = "<cmd>Oil<CR>";
        key = "<leader>-";
        options.desc = "File navigation";
      }

      # Snacks Picker (f for find)
      {
        action = "<cmd>lua Snacks.picker.files()<CR>";
        key = "<leader>ff";
        options.desc = "Find files";
      }
      {
        action = "<cmd>lua Snacks.picker.recent()<CR>";
        key = "<leader>fr";
        options.desc = "Find recent files";
      }
      {
        action = "<cmd>lua Snacks.picker.grep()<CR>";
        key = "<leader>fg";
        options.desc = "Live grep";
      }
      {
        action = "<cmd>lua Snacks.picker.buffers()<CR>";
        key = "<leader>fb";
        options.desc = "Find buffers";
      }
      {
        action = "<cmd>lua Snacks.picker.grep_buffers()<CR>";
        key = "<leader>fB";
        options.desc = "Grep open buffers";
      }
      {
        action = "<cmd>lua Snacks.picker.help()<CR>";
        key = "<leader>fh";
        options.desc = "Help tags";
      }
      {
        action = "<cmd>lua Snacks.picker.git_files()<CR>";
        key = "<leader>fp";
        options.desc = "Git files aka find in project";
      }
      {
        action = "<cmd>lua Snacks.picker.lsp_symbols()<CR>";
        key = "<leader>ls";
        options.desc = "LSP symbols";
      }
    ];
    plugins = {
      oil.enable = true;
      fugitive.enable = true;
      gitsigns.enable = true;
      diffview.enable = true;
      nvim-autopairs.enable = true;

      blink-cmp = {
        enable = true;
        setupLspCapabilities = true;
        settings = {
          keymap.preset = "super-tab";
          cmdline = {
            enabled = true;
            keymap.preset = "inherit";
            completion = {
              menu.auto_show = true;
              ghost_text.enabled = true;
              list.selection.preselect = false;
            };
          };
          completion = {
            menu.border = "rounded";
            accept.auto_brackets.enabled = true;
            documentation = {
              auto_show = true;
              window.border = "rounded";
            };
          };
        };
      };

      lualine.enable = true;
      which-key.enable = true;
      web-devicons.enable = true;
      snacks = {
        enable = true;
        settings = {
          input.enabled = true;
          animate.enabled = true;
          terminal.enabled = true;
          picker = {
            enabled = true;
            layout = "telescope";
          };
        };
      };

      telescope = {
        enable = true;
        extensions = {
          fzf-native.enable = true;
          file-browser.enable = true;
        };
      };

      treesitter-context.enable = true;
      treesitter-textobjects.enable = true;
      treesitter = {
        enable = true;
        indent.enable = true;
        highlight.enable = true;
        # folding.enable = true;
      };

      lsp = {
        enable = true;
        inlayHints = true;
        servers = {
          clangd.enable = true;
          marksman.enable = true;
          nil_ls.enable = true;
          rust_analyzer = {
            enable = true;
            installRustc = false;
            installCargo = false;
            package = pkgs.rust-analyzer-nightly;
          };
          # bashls.enable = true;
          # dockerls.enable = true;
          # html.enable = true;
          # pyright.enable = true;
          # svelte.enable = false;
          # tailwindcss.enable = true;
          # ts_ls.enable = true;
        };
      };

      # indent-blankline = {
      #   enable = true;
      #   settings = {
      #     indent = {
      #       char = "│";
      #     };
      #   };
      # };
    };
  };
}
