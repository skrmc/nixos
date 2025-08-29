{ pkgs, name, ... }:
{
  nixpkgs.system = "x86_64-linux";
  networking.hostName = "KAGURA";

  imports = [
    ./hardware-configuration.nix
  ];

  # Custom Packages
  environment.systemPackages = with pkgs; [
    spotify
    google-chrome
    termius
    vscode
    moonlight-qt
  ];

  home-manager.users.anon = {
    wayland.windowManager.hyprland = {
      settings = {
        exec-once = [
          "hyprctl hyprsunset temperature 5800"
        ];
        monitor = [
          # "eDP-1, highrr, auto, 1.25"
          "eDP-1, disable"
          # "HDMI-A-1, 1920x1080@120, auto, 1.25"
          # "HDMI-A-1, 3840x2160@60, auto, 2.5"
          "DP-2, 2560x1440@240, auto, 1.33"
        ];
      };
    };
  };
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
    ];
  };
}
