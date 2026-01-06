{
  pkgs,
  user,
  colors,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    # --- Desktop ---
    mpv
    pavucontrol
    wl-clipboard
    xdg-utils
    thunar
    thunar-volman
    kdePackages.breeze
    kdePackages.kdenlive
    google-chrome
    # wlsunset
    # swaybg

    # --- Visuals ---
    bibata-cursors
    papirus-icon-theme

    # --- Development ---
    gh
    gcc
    gitui
    gnumake
    (fenix.complete.withComponents [
      "cargo"
      "clippy"
      "rust-src"
      "rustc"
      "rustfmt"
    ])
    rust-analyzer-nightly

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
    zip
  ];

  users.defaultUserShell = pkgs.fish;

  hardware.uinput.enable = true;
  users.users.${user}.extraGroups = [ "uinput" ];
  services.sunshine = {
    enable = true;
    capSysAdmin = true;
    openFirewall = true;
  };

  programs = {
    adb.enable = true;
    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        stdenv.cc.cc
        curl
        openssl
        attr
        libssh
        util-linux
        systemd
        glib
        libglvnd
      ];
    };
    fish = {
      enable = true;
      shellAliases = {
        ls = "ls --color=auto";
        ll = "ls --color=auto -lha";
        bld = "sudo nixos-rebuild switch --flake";
        cln = "sudo nix-collect-garbage --delete-old";
        rbk = "sudo nixos-rebuild switch --rollback";
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
    zoxide = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
    };
    # --- Desktop ---
    dconf.enable = true;
    obs-studio = {
      enable = true;
      enableVirtualCamera = true;
      plugins = with pkgs.obs-studio-plugins; [
        obs-vaapi
        obs-backgroundremoval
        obs-pipewire-audio-capture
      ];
    };
  };
}
