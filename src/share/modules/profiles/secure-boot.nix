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
    enable = lib.mkEnableOption "Secure Boot via Lanzaboote";

    pkiBundle = lib.mkOption {
      type = lib.types.str;
      default = "/var/lib/sbctl";
      description = "Directory holding the Secure Boot PKI bundle.";
    };

    autoGenerateKeys = lib.mkEnableOption "automatic key generation when the PKI bundle is empty";

    autoEnrollKeys = lib.mkEnableOption "automatic key enrollment on the next boot";
  };

  config = lib.mkIf cfg.enable {
    boot = {
      loader.systemd-boot.enable = lib.mkForce false;
      lanzaboote = {
        enable = true;
        inherit (cfg) pkiBundle;
        inherit (config.boot.loader.systemd-boot) configurationLimit;
        autoGenerateKeys.enable = cfg.autoGenerateKeys;
        autoEnrollKeys.enable = cfg.autoEnrollKeys;
      };
    };
  };
}
