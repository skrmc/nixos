{
  config,
  inputs,
  lib,
  ...
}:
let
  cfg = config.profiles.secureBoot.lanzaboote;
in
{
  imports = [ inputs.lanzaboote.nixosModules.lanzaboote ];

  options.profiles.secureBoot.lanzaboote = {
    enable = lib.mkEnableOption "Lanzaboote-backed Secure Boot";

    pkiBundle = lib.mkOption {
      type = lib.types.str;
      default = "/var/lib/sbctl";
      description = "Persistent directory used to store Secure Boot PKI material.";
    };

    autoGenerateKeys = lib.mkEnableOption "automatic Secure Boot key generation when the PKI bundle is empty";

    autoEnrollKeys = lib.mkEnableOption "automatic Secure Boot key enrollment on the next reboot";
  };

  config = lib.mkIf cfg.enable {
    boot.loader.systemd-boot.enable = lib.mkForce false;
    boot.lanzaboote = {
      enable = true;
      pkiBundle = cfg.pkiBundle;
      autoGenerateKeys.enable = cfg.autoGenerateKeys;
      autoEnrollKeys.enable = cfg.autoEnrollKeys;
    };
  };
}
