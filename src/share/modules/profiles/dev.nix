{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.profiles.dev;
in
{
  options.profiles.dev.enable = lib.mkEnableOption "development tools";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      gh
      gcc
      gdb
      gitui
      gnumake
      cmake
      pkg-config
      python314
      nixfmt

      clang
      clang-tools

      rust-analyzer-nightly
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
