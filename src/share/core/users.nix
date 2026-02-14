{ pkgs, user, ... }:
let
  keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB8z6wE615ikEDjQdvGjMzpchxosnnk0DsgAOuInxHN8"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILhWdus6cCN85OBuNEsGzwx8p7qYPPyfJoH3uIsEP5IG"
  ];
in
{
  users = {
    mutableUsers = false;
    users.root.openssh.authorizedKeys.keys = keys;
    users.${user} = {
      uid = 1000;
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "tty"
        "audio"
        "video"
        "input"
        "uinput"
      ];
      hashedPasswordFile = "/persist/etc/secrets/${user}.hash";
      openssh.authorizedKeys.keys = keys;
    };
  };

  services.getty.autologinUser = "${user}";
}
