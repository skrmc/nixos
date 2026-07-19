{
  config,
  lib,
  pkgs,
  user,
  ...
}:
let
  cfg = config.profiles.virt;
in
{
  options.profiles.virt.enable = lib.mkEnableOption "virtualization tools";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      docker-compose
      # quickemu
      # qemu
    ];

    users.users.${user}.extraGroups = [ "kvm" ];

    virtualisation = {
      containers.enable = true;
      podman = {
        enable = true;
        dockerCompat = true;
        defaultNetwork.settings.dns_enabled = true;
      };
    };
  };
}
