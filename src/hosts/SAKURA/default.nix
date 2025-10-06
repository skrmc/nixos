{
  pkgs,
  config,
  inputs,
  user,
  ...
}:
{
  nixpkgs.system = "x86_64-linux";
  networking.hostName = "SAKURA";

  imports = [
    "${inputs.self}/src/share/system/nvidia.nix"
    ./hardware-configuration.nix
  ];

  boot.loader.timeout = 3;

  programs = {
    obs-studio = {
      package = (
        pkgs.obs-studio.override {
          cudaSupport = true;
        }
      );
    };
  };

  environment.systemPackages = with pkgs; [
    nvtopPackages.full
    google-chrome
    moonlight-qt
    obsidian
    vscode
  ];

  # Home Manager
  home-manager.users.${user} = {
    wayland.windowManager.hyprland = {
      settings = {
        exec-once = [
          "hyprctl hyprsunset temperature 6200"
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
