{ pkgs, ... }:

{
  users = {
    mutableUsers = false;
    users = {
      anon = {
        description = "ANON";
        isNormalUser = true;
        uid = 1000;
        extraGroups = [
          "wheel"
          # "networkmanager"
        ];
        hashedPassword = "$y$j9T$KbNyfJhGdAopilIWPoXQc1$h/CPGxQdYAK/4Q.PMUVdSyJLNjNX5kdFEPDwq.x4Ls0";
      };
    };
  };

  /*
    services.displayManager.autoLogin = {
      enable = true;
      user = "anon";
    };

    services.getty.autologinUser = "anon";
  */

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "Hyprland";
        user = "anon";
      };
    };
  };
}
