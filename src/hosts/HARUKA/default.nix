{
  nixpkgs.system = "aarch64-linux";
  networking.hostName = "HARUKA";

  imports = [
    ./hardware-configuration.nix
  ];
}
