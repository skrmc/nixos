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
    rust.enable = true;
    virt.enable = true;
    android.enable = true;
    creative.enable = true;
    gaming.enable = true;
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
