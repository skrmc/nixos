{
  pkgs,
  config,
  inputs,
  user,
  ...
}:
{
  networking.hostName = "SAKUTA";
  imports = [
    "${inputs.self}/src/share/modules/desktop"
    "${inputs.self}/src/share/modules/hardware/nvidia.nix"
    ./hardware-configuration.nix
  ];

  environment.systemPackages = with pkgs; [
    nvtopPackages.full
  ];

  programs.obs-studio.package = (
    pkgs.obs-studio.override {
      cudaSupport = true;
    }
  );
}
