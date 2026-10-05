{
  config,
  lib,
  ...
}:
let
  cfg = config.profiles.sunshine;
in
{
  options.profiles.sunshine.enable = lib.mkEnableOption "Sunshine game streaming host";

  config = lib.mkIf cfg.enable {
    services.sunshine = {
      enable = true;
      capSysAdmin = true;
      openFirewall = true;
    };
  };
}
