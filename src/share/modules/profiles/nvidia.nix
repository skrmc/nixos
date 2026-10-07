{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.profiles.nvidia;
  hasDesktop = config.desktop != null;
in
{
  options.profiles.nvidia.enable = lib.mkEnableOption "NVIDIA GPU support";

  config = lib.mkIf cfg.enable {
    environment = {
      sessionVariables = {
        LIBVA_DRIVER_NAME = "nvidia";
        NVD_BACKEND = "direct";
      };
      systemPackages = [ pkgs.nvtopPackages.full ];
    };

    services.xserver.videoDrivers = [ "nvidia" ];

    hardware = {
      graphics = {
        enable = true;
        extraPackages = with pkgs; [
          libva-vdpau-driver
          nvidia-vaapi-driver
        ];
      };
      nvidia-container-toolkit.enable = true;
      nvidia = {
        open = true;
        modesetting.enable = true;
        package = config.boot.kernelPackages.nvidiaPackages.beta;
        nvidiaSettings = hasDesktop;
        powerManagement.enable = hasDesktop;
      };
    };
  };
}
