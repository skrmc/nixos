{ pkgs, user, ... }:
{
  environment.systemPackages = with pkgs; [
    aria2
    bubblewrap
    cachix
    caligula
    evtest
    file
    ffmpeg
    gh
    hostapd
    imagemagick
    iw
    jq
    libnotify
    lsof
    ncdu
    nixfmt
    poppler-utils
    powertop
    python314
    rclone
    ripgrep
    sbctl
    tree
    unzip
    xxd
    zip
  ];

  users.defaultUserShell = pkgs.fish;

  hardware.uinput.enable = true;

  programs = {
    direnv.enable = true;
    nix-index-database.comma.enable = true;
    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        alsa-lib
        attr
        cacert
        curl
        glib
        libglvnd
        libssh
        openssl
        stdenv.cc.cc
        systemd
        util-linux
        zlib
      ];
    };
    nh = {
      enable = true;
      flake = "/home/${user}/.config/nixos";
      clean = {
        enable = true;
        dates = "weekly";
        extraArgs = "--keep 5 --keep-since 30d";
      };
    };
    fish = {
      enable = true;
      shellAliases = {
        ls = "ls --color=auto";
        ll = "ls --color=auto -lha";
        bld = "nh os switch";
        cln = "nh clean all";
      };
    };
    git = {
      enable = true;
      config = {
        user = {
          name = "Yejia Zhang";
          email = "Yejia995@gmail.com";
        };
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
      extraConfig = ''
        set -g mouse on
        set -g renumber-windows on
        set -g set-clipboard on
      '';
    };
    zoxide = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
    };
  };
}
