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
      cachix
      # clang
      # clang-tools
      cmake
      gcc
      gdb
      gh
      gitui
      gnumake
      go
      nixfmt
      pkg-config
      python314
      rust-analyzer-nightly
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
