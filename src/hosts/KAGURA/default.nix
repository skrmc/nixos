{ pkgs, user, ... }:
{
  nixpkgs.system = "x86_64-linux";
  networking.hostName = "KAGURA";

  imports = [
    ./hardware-configuration.nix
  ];

  environment.systemPackages = with pkgs; [
    google-chrome
    obsidian
    spotify
    termius
    vscode
    moonlight-qt
  ];

  home-manager.users.${user} = {
    wayland.windowManager.sway = {
      config = {
        output = {
          eDP-1 = {
            mode = "1920x1200@60Hz";
            scale = "1.25";
          };
          HDMI-A-1 = {
            mode = "3840x2160@60Hz";
            scale = "2";
          };
        };
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
