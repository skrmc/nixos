{ pkgs, config, ... }:
{
  environment = {
    sessionVariables = {
      CUDA_PATH = "${pkgs.cudatoolkit}";
      LD_LIBRARY_PATH = [
        "/run/opengl-driver/lib"
        "/run/opengl-driver-32/lib"
      ];
      NVD_BACKEND = "direct";
    };
    systemPackages = with pkgs; [
      nvtopPackages.full
    ];
  };
  # nixpkgs.config.cudaSupport = true;
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
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      # forceFullCompositionPipeline = true;
      open = true;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.beta;
    };
  };
}
