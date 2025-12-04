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
            char = "│";
          };
        };
      };
      blink-cmp = {
        enable = true;
        setupLspCapabilities = true;
        settings.keymap.preset = "super-tab";
      };
      nix = {
        enable = true;
      };
      lsp = {
        enable = true;
        servers = {
          clangd.enable = true;
          marksman.enable = true;
          nil_ls.enable = true;
          pyright.enable = true;
          rust_analyzer = {
            enable = true;
            installRustc = false;
            installCargo = false;
          };
          # bashls.enable = true;
          # dockerls.enable = true;
          # html.enable = true;
          # svelte.enable = false;
          # tailwindcss.enable = true;
          # ts_ls.enable = true;
        };
      };
    };
  };
}
