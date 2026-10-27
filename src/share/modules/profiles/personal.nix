{
  config,
  lib,
  user,
  ...
}:
let
  cfg = config.profiles.personal;
  keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB8z6wE615ikEDjQdvGjMzpchxosnnk0DsgAOuInxHN8"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILhWdus6cCN85OBuNEsGzwx8p7qYPPyfJoH3uIsEP5IG"
  ];
in
{
  options.profiles.personal.enable = lib.mkEnableOption "personal login settings";

  config = lib.mkIf cfg.enable {
    security.sudo.wheelNeedsPassword = false;

    users.users.${user} = {
      hashedPasswordFile = "/persist/etc/secrets/${user}.hash";
      openssh.authorizedKeys.keys = keys;
    };

    services.getty.autologinUser = user;
  };
}
