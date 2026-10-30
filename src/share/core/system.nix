{ lib, pkgs, ... }:
{
  boot = {
    loader = {
      timeout = lib.mkDefault 0;
      systemd-boot = {
        enable = true;
        configurationLimit = lib.mkDefault 10;
      };
      efi.canTouchEfiVariables = true;
    };
    kernelParams = [ "consoleblank=60" ];
    supportedFilesystems = [ "ntfs" ];
  };

  time.timeZone = "America/Chicago";
  # time.timeZone = "America/New_York";
  # time.timeZone = "Asia/Shanghai";
  i18n.defaultLocale = "en_US.UTF-8";

  zramSwap.enable = true;
  swapDevices = lib.mkForce [ ];
  hardware.uinput.enable = true;

  programs = {
    fish.enable = true;
    git.enable = true;
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
  };

  services = {
    openssh = {
      enable = true;
      openFirewall = false;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
      };
    };
    fwupd.enable = true;
    earlyoom.enable = true;
    journald.settings.Journal.SystemMaxUse = "500M";
  };

  documentation.man.cache.enable = false;

  environment = {
    systemPackages = with pkgs; [
      bubblewrap
      cachix
      caligula
      evtest
      file
      hostapd
      iw
      jq
      libnotify
      lsof
      ncdu
      powertop
      python314
      ripgrep
      sbctl
      tree
      unzip
      xxd
      zip
    ];
    localBinInPath = true;
    sessionVariables.NIX_PAGER = "cat";
  };

  nix = {
    optimise.automatic = true;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      download-buffer-size = 1073741824; # 1GB
      warn-dirty = false;
    };
  };
}
