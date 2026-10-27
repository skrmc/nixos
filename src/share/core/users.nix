{ user, ... }:
{
  users = {
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
