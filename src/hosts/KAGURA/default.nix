{
  pkgs,
  user,
  ...
}:
{
  networking.hostName = "KAGURA";
  system.stateVersion = "25.11";
  home-manager.users = {
    ${user}.home.stateVersion = "26.05";
    root.home.stateVersion = "26.05";
  };

  profiles = {
    personal.enable = true;
    development.enable = true;
    virtualization.enable = true;
    android.enable = true;
    creative.enable = true;
    entertainment.enable = true;
    laptop.enable = true;
  };
  desktop = "wayland";
  imports = [
    ./hardware-configuration.nix
  ];

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
    ];
  };
}
