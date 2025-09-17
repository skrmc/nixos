{
  pkgs,
  config,
  user,
  ...
}:
{
  nixpkgs.system = "x86_64-linux";
  networking.hostName = "SAKUYA";

  imports = [
    ./hardware-configuration.nix
  ];

  systemd.services.startup-tasks = {
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash /opt/boot.sh";
    };
    path = with pkgs; [
      util-linux
      coreutils
      iputils
      systemd
      rclone
      podman
      docker-compose
    ];
  };

  # Custom Packages
  environment = {
    variables = {
      NVD_BACKEND = "direct";
    };
    systemPackages = with pkgs; [
      nvtopPackages.full
    ];
  };

  # Graphic Settings
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      libva-vdpau-driver
      nvidia-vaapi-driver
      libvdpau-va-gl
    ];
  };
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    # forceFullCompositionPipeline = true;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };
  hardware.nvidia-container-toolkit.enable = true;

  # Home Manager
  home-manager.users.${user} = {
    wayland.windowManager.sway = {
      config = {
        output = {
          eDP-1 = {
            disable = "";
          };
        };
      };
    };
  };
}
