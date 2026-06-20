{
  pkgs,
  config,
  inputs,
  user,
  ...
}:
{
  networking.hostName = "SAKUYA";
  profiles.virt.enable = true;

  imports = [
    "${inputs.self}/src/share/modules/hardware/nvidia.nix"
    ./hardware-configuration.nix
  ];

  # systemd.services.startup-tasks = {
  #   wantedBy = [ "multi-user.target" ];
  #   after = [ "network-online.target" ];
  #   wants = [ "network-online.target" ];
  #   serviceConfig = {
  #     Type = "oneshot";
  #     ExecStart = "${pkgs.bash}/bin/bash /opt/boot.sh";
  #   };
  #   path = with pkgs; [
  #     util-linux
  #     coreutils
  #     iputils
  #     systemd
  #     rclone
  #     podman
  #     docker-compose
  #   ];
  # };
}
