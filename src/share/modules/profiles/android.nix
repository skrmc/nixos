{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.profiles.android;
in
{
  options.profiles.android.enable = lib.mkEnableOption "Android tools";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      android-tools
      frida-tools
      scrcpy
    ];
  };
}
