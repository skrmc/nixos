{
  config,
  pkgs,
  ...
}:
{
  boot.initrd.supportedFilesystems = [ "btrfs" ];
  boot.initrd.systemd.services.rollback-root = {
    description = "Rollback btrfs root subvolume";
    requiredBy = [ "initrd-root-fs.target" ];
    after = [ "initrd-root-device.target" ];
    before = [
      "sysroot.mount"
      "initrd-root-fs.target"
    ];
    path = with pkgs; [
      btrfs-progs
      coreutils
      findutils
      util-linux
    ];
    unitConfig.DefaultDependencies = false;
    serviceConfig.Type = "oneshot";
    script = ''
      set -euo pipefail
      storage="/run/btrfs"

      mkdir -p "$storage"
      mount -t btrfs -o subvol=/ "${config.fileSystems."/".device}" "$storage"

      if [ -e "$storage/root" ]; then
          mv "$storage/root" "$storage/root-archive/$(date -u +%Y%m%d-%H%M%S)"
      fi

      find "$storage/root-archive" -mindepth 1 -maxdepth 1 \
          | sort | head -n -10 | xargs -r btrfs subvolume delete --recursive

      btrfs subvolume snapshot "$storage/root-blank" "$storage/root"

      umount "$storage"
    '';
  };

  environment.persistence."/persist" = {
    hideMounts = true;

    files = [
      "/etc/machine-id"
      "/etc/ssh/ssh_host_ed25519_key"
    ];

    directories = [
      "/root"
      "/var/log"
      "/var/lib"
    ];
  };

  services.btrfs.autoScrub = {
    enable = true;
    interval = "weekly";
    fileSystems = [ "/" ];
  };
}
