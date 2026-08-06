{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.profiles.container;
in
{
  options.profiles.container.enable = lib.mkEnableOption "container tools";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      docker-compose
    ];

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
