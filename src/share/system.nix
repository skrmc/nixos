{ pkgs, ... }:

{
  boot = {
    loader = {
      timeout = 0;
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    supportedFilesystems = [ "ntfs" ];
  };

  # Podman Settings
  virtualisation.containers.enable = true;
  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };
  environment.systemPackages = with pkgs; [
    docker-compose
  ];

  # Network Settings
  # services.tailscale.enable = true;
  networking = {
    firewall = {
      enable = false;
      allowedTCPPorts = [
        443
        3000
        5173
        5900
      ];
      allowedUDPPortRanges = [
        {
          from = 60000;
          to = 65535;
        }
      ];
    };
    wireless.iwd.enable = true;
    # networkmanager.enable = true;
    # networkmanager.wifi.backend = "iwd";
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
          fcitx5-gtk
          fcitx5-chinese-addons
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
            "Groups/0" = {
              Name = "Default";
              "Default Layout" = "us";
              DefaultIM = "keyboard-us";
            };
            "Groups/0/Items/0".Name = "keyboard-us";
            "Groups/0/Items/1".Name = "pinyin";
            GroupOrder."0" = "Default";
          };
        };
      };
    };
  };

  zramSwap.enable = true;

  # services.openssh.enable = true;
  # security.polkit.enable = true;
  security.sudo.wheelNeedsPassword = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  environment.variables = {
    NIX_PAGER = "cat";
    NIXOS_OZONE_WL = "1";
    NIXPKGS_ALLOW_UNFREE = "1";
  };

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  system.stateVersion = "25.05";
}
