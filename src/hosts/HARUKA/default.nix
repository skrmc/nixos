{
  nixpkgs.system = "aarch64-linux";
  networking.hostName = "HARUKA";

  imports = [
    ./hardware-configuration.nix
  ];

  home-manager.users.anon = {
    wayland.windowManager.hyprland = {
      settings = {
        exec-once = [
          "hyprctl hyprsunset temperature 5800"
        ];
        monitor = [
          "Virtual-1, 3840x2160@60, auto, 3"
        ];
      };
    };
  };
}
