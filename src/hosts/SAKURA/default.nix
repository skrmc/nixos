{
  pkgs,
  config,
  user,
  ...
}:
{
  nixpkgs.system = "x86_64-linux";
  networking.hostName = "SAKURA";

  imports = [
    ./hardware-configuration.nix
  ];

  systemd.services."enable-wifi" = {
    description = "Enable WiFi Adapter after iwd starts";
    after = [ "iwd.service" ];
    wants = [ "iwd.service" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = [
        "/run/current-system/sw/bin/sh -c 'sleep 5 && /run/current-system/sw/bin/iwctl adapter phy0 set-property Powered on &'"
      ];
      RemainAfterExit = true;
    };
    wantedBy = [ "network.target" ];
  };

  # Game-related
  # programs = {
  #   gamescope = {
  #     enable = true;
  #     capSysNice = true;
  #   };
  #   steam = {
  #     enable = true;
  #     gamescopeSession.enable = true;
  #     remotePlay.openFirewall = true;
  #     dedicatedServer.openFirewall = true;
  #     localNetworkGameTransfers.openFirewall = true;
  #   };
  # };

  # Custom Packages
  environment = {
    variables = {
      NVD_BACKEND = "direct";
    };
    systemPackages = with pkgs; [
      nvtopPackages.full
      google-chrome
      obsidian
      spotify
      termius
      vscode
      moonlight-qt
    ];
  };

  # Graphic Settings
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      libva-vdpau-driver
      nvidia-vaapi-driver
      libvdpau-va-gl
    ];
  };
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    # forceFullCompositionPipeline = true;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };

  # Home Manager
  home-manager.users.${user} = {
    wayland.windowManager.sway = {
      config = {
        output = {
          eDP-1 = {
            disable = "";
          };
          HDMI-A-1 = {
            mode = "1920x1080@120Hz";
            scale = "1";
          };
        };

        startup = [
          {
            command = "wlsunset -T 6200";
            always = true;
          }
          {
            command = "iwctl adapter phy0 set-property power on";
            always = true;
          }
        ];
      };
    };
  };
}
