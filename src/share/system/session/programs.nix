{
  pkgs,
  user,
  colors,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    # --- Android ---
    android-tools
    frida-tools
    scrcpy

    # --- Development ---
    gh
    gcc
    gdb
    gitui
    gnumake
    nixfmt

    clang
    clang-tools

    rust-analyzer-nightly
    (fenix.complete.withComponents [
      "cargo"
      "clippy"
      "rust-src"
      "rustc"
      "rustfmt"
    ])

    # --- Utilities ---
    aria2
    cachix
    caligula
    clash-meta
    ffmpeg
    imagemagick
    localsend
    ncdu
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
  };
}
