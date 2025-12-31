{ pkgs, user, ... }:

{
  users = {
    mutableUsers = false;
    users = {
      ${user} = {
        isNormalUser = true;
        uid = 1000;
        extraGroups = [
          "wheel"
          "tty"
        ];
        hashedPasswordFile = "/persist/etc/secrets/${user}.hash";
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID5tJBSAhiSzNa055Uw4mdqo2m/16FjUH+rfsnC+l9b6"
        ];
      };
    };
  };

  services.getty.autologinUser = "${user}";
}
