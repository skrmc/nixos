{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.profiles.rust;
in
{
  options.profiles.rust.enable = lib.mkEnableOption "Rust development tools";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
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
