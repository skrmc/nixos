{ config, lib, ... }:
let
  cfg = config.profiles.laptop;
in
{
  options.profiles.laptop.enable = lib.mkEnableOption "laptop-specific power management";

  config = lib.mkIf cfg.enable {
    services.tlp = {
      enable = true;
      settings = {
        START_CHARGE_THRESH_BAT0 = 70;
        STOP_CHARGE_THRESH_BAT0 = 80;
      };
    };
  };
}
