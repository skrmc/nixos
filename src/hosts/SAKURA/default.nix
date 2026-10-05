{
  pkgs,
  inputs,
  user,
  ...
}:
{
  networking.hostName = "SAKURA";
  system.stateVersion = "25.11";
  home-manager.users = {
    ${user}.home.stateVersion = "26.05";
    root.home.stateVersion = "26.05";
  };

  profiles = {
    personal.enable = true;
    development.enable = true;
    container.enable = true;
    virtualization.enable = true;
    android.enable = true;
    creative.enable = true;
    entertainment.enable = true;
    laptop.enable = true;
    secureBoot.lanzaboote = {
      enable = true;
      autoGenerateKeys = true;
      autoEnrollKeys = true;
    };
  };
  desktop = "wayland";

  imports = [
    "${inputs.self}/src/share/modules/hardware/nvidia.nix"
    ./hardware-configuration.nix
  ];

  programs.obs-studio.package = pkgs.obs-studio.override {
    cudaSupport = true;
  };

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
