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

  programs = {
    obs-studio = {
      package = (
        pkgs.obs-studio.override {
          cudaSupport = true;
        }
      );
    };
  };

  environment = {
    variables = {
      NVD_BACKEND = "direct";
    };
    systemPackages = with pkgs; [
      nvtopPackages.full
      google-chrome
      moonlight-qt
      obsidian
      vscode
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
    wayland.windowManager.hyprland = {
      settings = {
        exec-once = [
          "hyprctl hyprsunset temperature 6200"
          "iwctl adapter phy0 set-property power on"
        ];
        monitor = [
          # "eDP-1, 2560x1600@165, auto, 1.6666"
          # "eDP-1, 2560x1600@165, -1280x0, 2"
          "eDP-1, disable"
          # "DP-2, 2560x1440@240, auto, 1.3333"
          # "HDMI-A-1, 2560x1440@240, auto, 1.3333"
          "HDMI-A-1, 1920x1080@120, 0x0, 1"
        ];
      };
    };
  };
}
