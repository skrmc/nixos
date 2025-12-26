{
  config,
  lib,
  pkgs,
  ...
}:
{
  boot.initrd.supportedFilesystems = [ "btrfs" ];
  boot.initrd.postResumeCommands = lib.mkAfter ''
    set -euo pipefail

    mkdir -p /run/btrfs
    mount -t btrfs -o subvol=/ "${config.fileSystems."/".device}" /run/btrfs

    mkdir -p /run/btrfs/roots

    if [ -d /run/btrfs/root ]; then
      mv /run/btrfs/root "/run/btrfs/roots/$(date -u +%Y%m%d-%H%M%S)"
    fi

    for p in $(ls -1dt /run/btrfs/roots/* 2>/dev/null | tail -n +11); do
      btrfs subvolume delete --recursive "$p"
    done

    btrfs subvolume snapshot /run/btrfs/root-blank /run/btrfs/root

    umount /run/btrfs
  '';

  environment.persistence."/persist" = {
    hideMounts = true;

    files = [
      "/etc/machine-id"
    ];

    directories = [
      "/var/log"
      "/var/lib/iwd"
      "/var/lib/nixos"
      "/var/lib/bluetooth"
      "/var/lib/tailscale"
      "/var/lib/containers"
      "/var/lib/flatpak"
      "/var/lib/samba"
    ];
  };

  services.btrfs.autoScrub = {
    enable = true;
    interval = "monthly";
    fileSystems = [ "/" ];
  };
}
