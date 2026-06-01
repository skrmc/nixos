{
  pkgs,
  user,
  inputs,
  ...
}:
{
  networking.hostName = "KAGURA";
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
