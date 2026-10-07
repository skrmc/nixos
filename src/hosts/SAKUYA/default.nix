{ user, ... }:
{
  imports = [ ./hardware-configuration.nix ];

  networking.hostName = "SAKUYA";
  system.stateVersion = "25.11";
  home-manager.users = {
    ${user}.home.stateVersion = "26.05";
    root.home.stateVersion = "26.05";
  };

  profiles = {
    personal.enable = true;
    container.enable = true;
    nvidia.enable = true;
  };

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
