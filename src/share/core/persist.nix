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
        wantedBy = [ "initrd.target" ];
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

          mkdir -p "$storage/root-archive"
          if [ -e "$storage/root" ]; then
              mv "$storage/root" "$storage/root-archive/$(btrfs inspect-internal rootid "$storage/root")"
          fi

          btrfs subvolume snapshot "$storage/root-blank" "$storage/root"

          cd "$storage/root-archive"
          ls | sort -n | head -n -10 | xargs -r btrfs subvolume delete --recursive
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
