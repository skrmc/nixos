{
  pkgs,
  config,
  inputs,
  user,
  ...
}:
{
  boot.loader.timeout = 3;
  networking.hostName = "SAKURA";
  imports = [
    "${inputs.self}/src/share/system/nvidia.nix"
    ./hardware-configuration.nix
  ];

  environment.systemPackages = with pkgs; [
    nvtopPackages.full
    moonlight-qt
    texliveFull
    obsidian
    vscode
  ];

  programs.obs-studio.package = (
    pkgs.obs-studio.override {
      cudaSupport = true;
    }
  );

  boot.extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback
  ];
  boot.kernelModules = [ "v4l2loopback" ];
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=1 card_label="Integrated Camera" exclusive_caps=1
  '';

  # Home Manager
  home-manager.users.${user} = {
    xdg.configFile."niri/outputs.kdl".text = ''
      output "eDP-1" { off; }
      output "HDMI-A-1" { mode "1920x1080"; variable-refresh-rate; }
    '';
    # wayland.windowManager.hyprland = {
    #   settings = {
    #     exec-once = [
    #       "hyprctl hyprsunset temperature 6200"
    #     ];
    #     monitor = [
    #       # "eDP-1, 2560x1600@165, auto, 1.6666"
    #       # "eDP-1, 2560x1600@165, -1280x0, 2"
    #       "eDP-1, disable"
    #       # "DP-2, 2560x1440@240, auto, 1.3333"
    #       # "HDMI-A-1, 2560x1440@240, auto, 1.3333"
    #       "HDMI-A-1, 1920x1080@180, 0x0, 1"
    #     ];
    #   };
    # };
  };
}
