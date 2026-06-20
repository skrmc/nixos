{
  pkgs,
  user,
  inputs,
  ...
}:
{
  networking.hostName = "HARUKA";
  hardware.graphics.enable = true;
  imports = [
    "${inputs.self}/src/share/modules/desktop"
    ./hardware-configuration.nix
  ];
}
