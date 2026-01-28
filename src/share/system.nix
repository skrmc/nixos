{
  lib,
  pkgs,
  user,
  ...
}:

{
  imports = [
    ./system/battery.nix
    ./system/desktop.nix
    ./system/persist.nix
    ./system/programs.nix
    ./system/flatpak.nix
  ];
  boot = {
    loader = {
      timeout = lib.mkDefault 0;
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    # lanzaboote = {
    #   enable = true;
    #   pkiBundle = "/var/lib/sbctl";
    # };
    kernelParams = [ "consoleblank=300" ];
    supportedFilesystems = [ "ntfs" ];
  };

  # Containers and Virtualization
  environment.systemPackages = with pkgs; [
    docker-compose
    # virt-manager
    spice-gtk
    quickemu
    qemu
  ];
  users.users.${user}.extraGroups = [
    # "libvirtd"
    "kvm"
  ];
  virtualisation = {
    containers.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
    waydroid = {
      enable = true;
      package = pkgs.waydroid-nftables;
    };
    # libvirtd = {
    #   enable = true;
    #   qemu = {
    #     package = pkgs.qemu_kvm;
    #     swtpm.enable = true;
    #     ovmf = {
    #       enable = true;
    #       packages = [
    #         (pkgs.OVMF.override {
    #           secureBoot = true;
    #           tpmSupport = true;
    #         }).fd
    #       ];
    #     };
    #   };
    # };
  };

  # Network Settings
  services = {
    resolved.enable = true;
    tailscale.enable = true;
    # zerotierone.enable = true;
  };
  networking = {
    useDHCP = true;
    useNetworkd = true;
    firewall.enable = false;
    wireless.iwd.enable = true;
    # networkmanager.enable = true;
    # networkmanager.wifi.backend = "iwd";
  };
  systemd.network = {
    enable = true;
    wait-online.enable = true;
  };

  time.timeZone = "America/New_York";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    inputMethod = {
      type = "fcitx5";
      enable = true;
      fcitx5 = {
        waylandFrontend = true;
        addons = with pkgs; [
          qt6Packages.fcitx5-chinese-addons
          fcitx5-pinyin-moegirl
          fcitx5-pinyin-zhwiki
        ];
        # ignoreUserConfig = true;
        settings = {
          addons = {
            pinyin.globalSection = {
              CloudPinyinEnabled = "True";
              CloudPinyinIndex = 2;
            };
            cloudpinyin.globalSection = {
              Backend = "Google";
            };
          };
          globalOptions = {
            "Hotkey/TriggerKeys" = {
              "0" = "Super+space";
            };
          };
          inputMethod = {
            GroupOrder."0" = "Default";
            "Groups/0" = {
              Name = "Default";
              DefaultIM = "keyboard-us";
            };
            "Groups/0/Items/0".Name = "keyboard-us";
            "Groups/0/Items/1".Name = "pinyin";
          };
        };
      };
    };
  };

  zramSwap.enable = true;
  swapDevices = lib.mkForce [ ];

  services.openssh.enable = true;
  security.sudo.wheelNeedsPassword = false;

  security.polkit.enable = true;
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  environment.sessionVariables = {
    NIX_PAGER = "cat";
    NIXOS_OZONE_WL = "1";
    QT_QPA_PLATFORM = "wayland";

    # GTK_IM_MODULE = "fcitx";
    # QT_IM_MODULE = "fcitx";
    # XMODIFIERS = "@im=fcitx";
  };

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    download-buffer-size = 1073741824; # 1GB
  };

  system.stateVersion = "25.05";
}
