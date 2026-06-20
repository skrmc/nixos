{
  pkgs,
  user,
  inputs,
  ...
}:
{
  networking.hostName = "KAGURA";
  profiles = {
    dev.enable = true;
    virt.enable = true;
    android.enable = true;
    creative.enable = true;
    gaming.enable = true;
  };
  imports = [
    "${inputs.self}/src/share/modules/desktop"
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
