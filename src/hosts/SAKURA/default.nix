{
  pkgs,
  config,
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
  environment.systemPackages = with pkgs; [
    nvtopPackages.full
    google-chrome
    obsidian
    spotify
    termius
    vscode
    moonlight-qt
  ];

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
  home-manager.users.anon = {
    wayland.windowManager.hyprland = {
      settings = {
        exec-once = [
          "hyprctl hyprsunset temperature 6200"
          "iwctl adapter phy0 set-property power on"
        ];
        env = [
          "NVD_BACKEND, direct"
        ];
        /*
          cursor = {
            no_hardware_cursors = 1;
            no_break_fs_vrr = 1;
          };
          render = {
            explicit_sync	= 0;
          };
          opengl = {
            nvidia_anti_flicker = 0;
          };
          misc = {
            vfr = 0;
          };
        */
        monitor = [
          # "eDP-1, 2560x1600@165, auto, 1.6666"
          # "eDP-1, 2560x1600@165, -1280x0, 2"
          "eDP-1, disable"
          # "DP-2, 2560x1440@240, auto, 1.33"
          # "HDMI-A-1, 2560x1440@240, auto, 1.33"
          "HDMI-A-1, 1920x1080@120, 0x0, 1"
        ];
      };
    };
  };
}
