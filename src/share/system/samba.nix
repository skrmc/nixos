{ user, ... }:

{
  services.samba = {
    enable = true;
    openFirewall = true;
    settings = {
      global = {
        "security" = "user";
        "hosts allow" = "192.168.0.0/16 127.0.0.1 localhost";
        "hosts deny" = "0.0.0.0/0";
      };
      "${user}" = {
        "path" = "/home/${user}/Public";
        "read only" = "no";
        "create mask" = "0644";
        "directory mask" = "0755";
        "force user" = "${user}";
      };
    };
  };
}
