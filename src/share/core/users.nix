{ pkgs, user, ... }:
{
  users = {
    defaultUserShell = pkgs.fish;
    mutableUsers = false;
    users.${user} = {
      uid = 1000;
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "audio"
        "video"
        "input"
        "uinput"
        "dialout"
      ];
    };
  };
}
