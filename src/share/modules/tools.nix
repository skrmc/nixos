{ pkgs, user, ... }:
{
  environment.systemPackages = with pkgs; [
    # --- Utilities ---
    aria2
    bubblewrap
    cachix
    caligula
    evtest
    ffmpeg
    imagemagick
    jq
    libnotify
    ncdu
    powertop
    rclone
    ripgrep
    sbctl
    tree
    unzip
    zip
    zlib
  ];

  users.defaultUserShell = pkgs.fish;

  hardware.uinput.enable = true;

  programs = {
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
        user.name = "Yejia";
        user.email = "Yejia995@gmail.com";
      };
    };
    tmux = {
      enable = true;
      escapeTime = 0;
      historyLimit = 5000;
    };
    zoxide = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
    };
  };
}
