{
  config,
  pkgs,
  utils,
  ...
}:
let
  device = "${utils.escapeSystemdPath config.fileSystems."/".device}.device";
in
{
  boot.initrd = {
    supportedFilesystems = [ "btrfs" ];
    systemd = {
      initrdBin = [ pkgs.findutils ];
      services.rollback-root = {
        description = "Rollback btrfs root subvolume";
        requiredBy = [ "sysroot.mount" ];
        requires = [ device ];
        after = [ device ];
        before = [ "sysroot.mount" ];
        unitConfig.DefaultDependencies = false;
        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = true;
        };
        script = ''
          set -euo pipefail
          storage="/run/btrfs"

          mkdir -p "$storage"
          mount -t btrfs -o subvol=/ "${config.fileSystems."/".device}" "$storage"

          if [ ! -d "$storage/root-blank" ]; then
              echo "<3>root-blank subvolume missing, keeping current root" >&2
              umount "$storage"
              exit 0
          fi

          if [ -e "$storage/root-new" ]; then
              btrfs subvolume delete --recursive "$storage/root-new"
          fi
          btrfs subvolume snapshot "$storage/root-blank" "$storage/root-new"

          mkdir -p "$storage/root-archive"
          if [ -e "$storage/root" ]; then
              mv "$storage/root" "$storage/root-archive/$(btrfs inspect-internal rootid "$storage/root")"
          fi
          mv "$storage/root-new" "$storage/root"

          cd "$storage/root-archive"
          ls | sort -n | head -n -10 | xargs -r btrfs subvolume delete --recursive \
              || echo "<4>failed to prune root archives" >&2
          cd /

          umount "$storage"
        '';
      };
    };
  };

  environment.persistence."/persist" = {
    hideMounts = true;

    files = [
      "/etc/machine-id"
      "/etc/ssh/ssh_host_ed25519_key"
      "/etc/ssh/ssh_host_rsa_key"
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
