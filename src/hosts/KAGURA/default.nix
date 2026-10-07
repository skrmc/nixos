{ pkgs, user, ... }:
{
  imports = [ ./hardware-configuration.nix ];

  networking.hostName = "KAGURA";
  system.stateVersion = "25.11";
  home-manager.users = {
    ${user}.home.stateVersion = "26.05";
    root.home.stateVersion = "26.05";
  };

  profiles = {
    personal.enable = true;
    development.enable = true;
    container.enable = true;
    android.enable = true;
    creative.enable = true;
    entertainment.enable = true;
    laptop.enable = true;
  };
  desktop = "wayland";

  hardware.graphics = {
    enable = true;
    extraPackages = [ pkgs.intel-media-driver ];
  };
}
