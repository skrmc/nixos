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
}
