{
  config,
  lib,
  pkgs,
  user,
  ...
}:
let
  cfg = config.profiles.gaming;
in
{
  options.profiles.gaming.enable = lib.mkEnableOption "gaming and game streaming";

  config = lib.mkIf cfg.enable {
    programs.steam.enable = true;

    services.sunshine = {
      enable = true;
      capSysAdmin = true;
      openFirewall = true;
    };

    home-manager.users.${user}.home.packages = with pkgs; [
      moonlight-qt
      prismlauncher
    ];
  };
}
