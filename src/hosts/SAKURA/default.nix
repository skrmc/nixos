{
  pkgs,
  config,
  inputs,
  user,
  ...
}:
{
  networking.hostName = "SAKURA";
  profiles.secureBoot.lanzaboote = {
    enable = true;
    autoGenerateKeys = true;
    autoEnrollKeys = true;
  };

  imports = [
    "${inputs.self}/src/share/modules/desktop"
    "${inputs.self}/src/share/modules/hardware/nvidia.nix"
    ./hardware-configuration.nix
  ];

  programs.obs-studio.package = (
    pkgs.obs-studio.override {
      cudaSupport = true;
    }
  );

  boot.extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback
  ];
  boot.kernelModules = [ "v4l2loopback" ];
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 card_label="Integrated Camera" exclusive_caps=1
  '';

  systemd.services.rfkill-unblock = {
    description = "Unblock rfkill at boot";
    wantedBy = [ "multi-user.target" ];
    before = [ "iwd.service" ];
    serviceConfig.Type = "oneshot";
    script = ''
      ${pkgs.util-linux}/bin/rfkill unblock all
    '';
  };

  # Home Manager
  home-manager.users.${user} = {
    xdg.configFile."niri/outputs.kdl".text = ''
      output "eDP-1" { off; }
      output "HDMI-A-1" { mode "2560x1440"; scale 1.2; }
      // output "PNP(SAC) G4Q L56051794302" { mode "2560x1440"; scale 1.2; }
    '';
    wayland.windowManager.hyprland = {
      settings = {
        # exec-once = [
        #   "hyprctl hyprsunset temperature 6200"
        # ];
        monitor = [
          # "eDP-1, disable"
          "eDP-1, 2560x1600@165, auto, 1.6"
          # "HDMI-A-1, 1920x1080@180, 0x0, 1"
        ];
      };
    };
  };
}
