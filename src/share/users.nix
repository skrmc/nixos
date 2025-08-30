{ pkgs, ... }:

let
  session = "${pkgs.hyprland}/bin/Hyprland";
  username = "anon";
in

{
  users = {
    mutableUsers = false;
    users = {
      ${username} = {
        isNormalUser = true;
        uid = 1000;
        extraGroups = [
          "wheel"
        ];
        hashedPassword = "$y$j9T$KbNyfJhGdAopilIWPoXQc1$h/CPGxQdYAK/4Q.PMUVdSyJLNjNX5kdFEPDwq.x4Ls0";
      };
    };
  };

  services.getty.autologinUser = "${username}";

  # services.greetd = {
  #   enable = true;
  #   settings = {
  #     initial_session = {
  #       command = "${session}";
  #       user = "${username}";
  #     };
  #     default_session = {
  #       command = "ls -a";
  #       user = "${username}";
  #     };
  #   };
  # };
}
