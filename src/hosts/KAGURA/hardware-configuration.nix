{
  config,
  lib,
  modulesPath,
  ...
}:

let
  fsefi = "/dev/disk/by-label/EFI";
  fslinux = "/dev/disk/by-label/Linux";
in
{
  fileSystems = {
    "/" = {
      device = fslinux;
      fsType = "btrfs";
      options = [
        "subvol=root"
        "compress=zstd"
      ];
    };

    "/nix" = {
      device = fslinux;
      fsType = "btrfs";
      options = [
        "subvol=nix"
        "compress=zstd"
        "noatime"
      ];
    };

    "/persist" = {
      device = fslinux;
      fsType = "btrfs";
      neededForBoot = true;
      options = [
        "subvol=persist"
        "compress=zstd"
      ];
    };

    "/home" = {
      device = fslinux;
      fsType = "btrfs";
      options = [
        "subvol=home"
        "compress=zstd"
      ];
    };

    "/boot" = {
      device = fsefi;
      fsType = "vfat";
      options = [ "umask=0077" ];
    };
  };

  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "thunderbolt"
        "nvme"
      ];
      kernelModules = [ ];
    };
    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];
  };

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
