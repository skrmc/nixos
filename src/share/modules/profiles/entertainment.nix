{
  config,
  lib,
  pkgs,
  user,
  ...
}:
let
  cfg = config.profiles.entertainment;
in
{
  options.profiles.entertainment.enable = lib.mkEnableOption "gaming and entertainment tools";

  config = lib.mkIf cfg.enable {
    programs.steam.enable = true;

    home-manager.users.${user}.home.packages = with pkgs; [
      moonlight-qt
      prismlauncher
    ];
  };
}
