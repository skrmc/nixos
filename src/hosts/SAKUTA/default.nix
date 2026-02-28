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

  # Home Manager
  home-manager.users.${user}.wayland.windowManager.hyprland = {
    settings = {
      monitor = [
        "eDP-1, 2560x1600@165, auto, 1.25"
        # "eDP-1, disable"
        # "HDMI-A-1, 1920x1080@180, auto, 1"
      ];
    };
  };
}
