# /etc/nixos/src/share/system/flatpak.nix

{ lib, pkgs, ... }:

let
  flatpaks = [
    "com.github.tchx84.Flatseal"
    "com.valvesoftware.Steam"
    "com.steamgriddb.SGDBoop"
    "com.discordapp.Discord"
    "org.telegram.desktop"
    "com.tencent.WeChat"
    "com.spotify.Client"
    "com.termius.Termius"
  ];
in
{
  services.flatpak.enable = true;

  xdg.portal = {
    enable = true;
    # wlr.enable = true;
    extraPortals = [
      # pkgs.xdg-desktop-portal-gtk
      # pkgs.xdg-desktop-portal-wlr
      pkgs.xdg-desktop-portal-hyprland
    ];
    config.common.default = [
      # "gtk"
      # "wlr"
      "hyprland"
    ];
  };

  systemd.services.flatpak-tasks = {
    unitConfig.ConditionACPower = true;

    serviceConfig.Type = "oneshot";
    path = [
      pkgs.curl
      pkgs.flatpak
    ];

    script = ''
      set -euo pipefail
      url=https://flathub.org/repo/flathub.flatpakrepo

      curl -fsS --connect-timeout 2 --max-time 10 \
        --retry 30 --retry-delay 2 --retry-all-errors --retry-max-time 300 \
        "$url" >/dev/null

      flatpak remote-add --if-not-exists --system flathub "$url"

      for app in ${lib.concatStringsSep " " flatpaks}; do
        [ -n "$app" ] && flatpak install --system -y --noninteractive --app --or-update flathub "$app"
      done

      flatpak uninstall --system --unused -y --noninteractive
      flatpak update --system -y --noninteractive
    '';
  };

  systemd.timers.flatpak-tasks = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      Unit = "flatpak-tasks.service";
      OnBootSec = "5min";
      RandomizedDelaySec = "2min";
    };
  };
}
