{
  pkgs,
  config,
  inputs,
  user,
  ...
}:
{
  networking.hostName = "SAKUYA";
  imports = [
    "${inputs.self}/src/share/system/hardware/nvidia.nix"
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

  home-manager.users.${user} = {
    wayland.windowManager.hyprland = {
      settings = {
        monitor = [
          "eDP-1, disable"
          # "eDP-1, 2560x1440@165, auto, 1.6666"
          # "DP-2, 2560x1440@240, auto, 1.3333"
          # "HDMI-A-1, 2560x1440@240, auto, 1.3333"
          # "HDMI-A-1, 1920x1080@120, 0x0, 1.25"
        ];
      };
    };
  };
}
