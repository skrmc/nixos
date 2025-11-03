{ pkgs, colors, ... }:

{
  environment.systemPackages = with pkgs; [
    # --- Desktop ---
    mpv
    pavucontrol
    wl-clipboard
    # wlsunset
    # swaybg
    nautilus
    xdg-utils

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
    sbctl
    tree
    unzip
  ];

  users.defaultUserShell = pkgs.fish;

  services.sunshine = {
    enable = true;
    capSysAdmin = true;
    openFirewall = true;
  };

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
    tmux = {
      enable = true;
      historyLimit = 5000;
    };
    # --- Desktop ---
    obs-studio = {
      enable = true;
      enableVirtualCamera = true;
      plugins = with pkgs.obs-studio-plugins; [
        obs-vaapi
        obs-backgroundremoval
        obs-pipewire-audio-capture
      ];
    };
    nautilus-open-any-terminal = {
      enable = true;
      terminal = "foot";
    };
  };
}
