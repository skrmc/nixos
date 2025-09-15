{ inputs, pkgs, ... }:

{
  services.flatpak.enable = true;
  environment.systemPackages = with pkgs; [
    # --- Desktop ---
    # spotify
    # google-chrome
    # moonlight-qt
    # termius
    # vscode
    mpv

    # --- Hyprland ---
    waycorner
    pwvucontrol
    wl-clipboard
    nautilus

    # --- Visuals ---
    bibata-cursors
    papirus-icon-theme

    # --- Development ---
    gh
    gcc
    gitui
    gnumake
    # bun
    # rustup
    # uv

    # --- Utilities ---
    aria2
    caligula
    clash-meta
    ffmpeg
    localsend
    ncdu
    nixfmt-rfc-style
    powertop
    rclone
    tree
    unzip
  ];
  users.defaultUserShell = pkgs.fish;
  programs = {
    nix-ld.enable = true;
    # dconf.enable = true;
    yazi.enable = true;
    openvpn3.enable = true;
    fish = {
      enable = true;
      shellAliases = {
        se = "sudoedit";
        ls = "ls --color=auto";
        ll = "ls --color=auto -lha";
        build = "sudo nixos-rebuild switch --flake /etc/nixos";
        clean = "sudo nix-collect-garbage --delete-old";
        # rollback = "sudo nixos-rebuild switch --rollback";
      };
    };
    git = {
      enable = true;
      config = {
        user.name = "SAKURA";
        user.email = "Yejia995@gmail.com";
      };
    };
    # --- Desktop ---
    # obs-studio = {
    #   enable = true;
    #   enableVirtualCamera = true;
    #   plugins = with pkgs.obs-studio-plugins; [
    #     obs-vaapi
    #     obs-backgroundremoval
    #   ];
    # };
    # --- Hyprland ---
    hyprland = {
      enable = true;
      withUWSM = true;
    };
    foot = {
      enable = true;
      theme = "dracula";
      enableFishIntegration = true;
      settings = {
        main = {
          font = "JetBrainsMono Nerd Font:size=11";
          selection-target = "both";
          initial-window-size-chars = "120x40";
          pad = "10x10";
        };
        mouse-bindings = {
          clipboard-paste = "BTN_RIGHT";
          select-extend = "none";
        };
        csd = {
          hide-when-maximized = "yes";
        };
      };
    };
    nautilus-open-any-terminal = {
      enable = true;
      terminal = "foot";
    };
    tmux = {
      enable = true;
      historyLimit = 5000;
    };
  };
}
