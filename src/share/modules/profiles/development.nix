{
  config,
  lib,
  pkgs,
  user,
  ...
}:
let
  cfg = config.profiles.development;
in
{
  options.profiles.development.enable = lib.mkEnableOption "development tools";

  config = lib.mkIf cfg.enable {
    home-manager.users.${user}.home.packages = with pkgs; [
      gdb
      gitui
      go
      rust-analyzer-nightly
      sqlc
      (fenix.complete.withComponents [
        "cargo"
        "clippy"
        "rust-src"
        "rustc"
        "rustfmt"
      ])
    ];
  };
}
