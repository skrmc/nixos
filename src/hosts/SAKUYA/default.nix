{ user, ... }:
{
  imports = [ ./hardware-configuration.nix ];

  networking.hostName = "SAKUYA";
  system.stateVersion = "25.11";
  home-manager.users = {
    ${user}.home.stateVersion = "26.05";
    root.home.stateVersion = "26.05";
  };

  profiles = {
    personal.enable = true;
    container.enable = true;
    nvidia.enable = true;
  };

  services.logind.settings.Login.HandleLidSwitch = "ignore";
}
