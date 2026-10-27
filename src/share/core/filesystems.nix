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
        "noatime"
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
        "noatime"
      ];
    };

    "/home" = {
      device = fslinux;
      fsType = "btrfs";
      options = [
        "subvol=home"
        "compress=zstd"
        "noatime"
      ];
    };

    "/boot" = {
      device = fsefi;
      fsType = "vfat";
      options = [ "umask=0077" ];
    };
  };
}
