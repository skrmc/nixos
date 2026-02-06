{
  pkgs,
  user,
  inputs,
  ...
}:
{
  networking.hostName = "KAGURA";
  imports = [
    "${inputs.self}/src/share/modules/desktop"
    ./hardware-configuration.nix
  ];

  home-manager.users.${user} = {
    # xdg.configFile."niri/outputs.kdl".text = ''
    #   output "eDP-1" {}
    #   output "HDMI-A-1" {}
    # '';
    wayland.windowManager.hyprland = {
      settings = {
        monitor = [
          # "eDP-1, disable"
          "eDP-1, highrr, auto, 1.25"
          "HDMI-A-1, 1920x1080@180, auto, 1"
          # "HDMI-A-1, 3840x2160@60, auto, 2.5"
          # "DP-2, 2560x1440@240, auto, 1.33"
        ];
      };
    };
  };

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
    ];
  };
}
