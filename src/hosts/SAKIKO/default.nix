{
  lib,
  pkgs,
  config,
  name,
  ...
}:
{
  nixpkgs.system = "x86_64-linux";
  networking.hostName = "SAKIKO";

  imports = [
    ./hardware-configuration.nix
  ];

  # Custom Packages
  environment.systemPackages = with pkgs; [
    nvtopPackages.full
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
  home-manager.users.anon = {
    wayland.windowManager.hyprland = {
      settings = {
        exec-once = [
          "hyprctl hyprsunset temperature 6200"
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
          "eDP-1, 2560x1440@165, auto, 1.6666"
          # "eDP-1, 2560x1600@165, -1280x0, 2"
          # "eDP-1, disable"
          # "DP-2, 2560x1440@240, auto, 1.33"
          # "HDMI-A-1, 2560x1440@240, auto, 1.33"
          # "HDMI-A-1, 1920x1080@120, 0x0, 1.25"
        ];
      };
    };
  };
}
