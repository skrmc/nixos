# /etc/nixos/src/share/system/flatpak.nix

{ lib, pkgs, ... }:

let
  flatpaks = [
    "com.github.tchx84.Flatseal"
    "com.valvesoftware.Steam"
    "com.discordapp.Discord"
    "com.termius.Termius"
    "com.spotify.Client"
    "com.tencent.WeChat"
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
    description = "Flatpak tasks (only on AC power, after network is online)";
    after = [ "systemd-networkd-wait-online.service" ];
    wantedBy = [ "multi-user.target" ];
    unitConfig.ConditionACPower = true;

    path = [
      pkgs.flatpak
      pkgs.gnugrep
    ];

    serviceConfig = {
      Type = "oneshot";
    };

    script = ''
      set -euo pipefail

      declared=$'${lib.concatStringsSep "\\n" flatpaks}\n'

      flatpak remote-add --if-not-exists --system flathub \
        https://flathub.org/repo/flathub.flatpakrepo
      flatpak update --system -y --noninteractive

      installed="$(flatpak list --app --columns=application --system || true)"

      if [ -n "$installed" ]; then
        for app in $installed; do
          if ! printf '%s' "$declared" | grep -F -x -q -- "$app"; then
            flatpak uninstall --system -y --noninteractive "$app"
          fi
        done
      fi

      for app in $declared; do
        [ -z "$app" ] && continue
        flatpak install --system -y --noninteractive --app --or-update flathub "$app"
      done

      flatpak uninstall --system --unused -y --noninteractive
      flatpak update --system -y --noninteractive
    '';
  };
}
