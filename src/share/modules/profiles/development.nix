{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.profiles.development;
in
{
  options.profiles.development.enable = lib.mkEnableOption "development tools";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      # clang
      # clang-tools
      cmake
      gcc
      gdb
      gitui
      gnumake
      go
      pkg-config
      rust-analyzer-nightly
      sqlc
      zlib
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
