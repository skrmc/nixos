{
  config,
  lib,
  pkgs,
  user,
  ...
}:
let
  cfg = config.profiles.creative;
in
{
  options.profiles.creative.enable = lib.mkEnableOption "creative applications";

  config = lib.mkIf cfg.enable {
    home-manager.users.${user}.home.packages = with pkgs; [
      # blender
      gimp3
      kdePackages.kdenlive
    ];
  };
}
