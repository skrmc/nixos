{
  pkgs,
  config,
  inputs,
  user,
  ...
}:
{
  networking.hostName = "SAKURA";
  system.stateVersion = "26.05";
  home-manager.users = {
    ${user}.home.stateVersion = "26.05";
    root.home.stateVersion = "26.05";
  };

  profiles = {
    personal.enable = true;
    rust.enable = true;
    virt.enable = true;
    android.enable = true;
    creative.enable = true;
    gaming.enable = true;
    laptop.enable = true;
  };
  desktop = "wayland";

  imports = [
    "${inputs.self}/src/share/modules/hardware/nvidia.nix"
    ./hardware-configuration.nix
  ];

  programs.obs-studio.package = pkgs.obs-studio.override {
    cudaSupport = true;
  };

  boot = {
    extraModulePackages = with config.boot.kernelPackages; [
      v4l2loopback
    ];
    kernelModules = [ "v4l2loopback" ];
    extraModprobeConfig = ''
      options v4l2loopback devices=1 card_label="Integrated Camera" exclusive_caps=1
    '';
  };
}
