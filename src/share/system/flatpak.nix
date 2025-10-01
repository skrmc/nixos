# /etc/nixos/src/share/system/flatpak.nix

{ lib, pkgs, ... }:

let
  flatpaks = [
    "com.github.tchx84.Flatseal"
    "com.valvesoftware.Steam"
    "com.discordapp.Discord"
    "com.termius.Termius"
    "com.spotify.Client"
    "us.zoom.Zoom"
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
    restartIfChanged = true;

    serviceConfig = {
      Type = "oneshot";
    };

    script = ''
      set -euo pipefail

      declared=$'${lib.concatStringsSep "\\n" flatpaks}\n'

      ${pkgs.flatpak}/bin/flatpak remote-add --if-not-exists --system flathub \
        https://flathub.org/repo/flathub.flatpakrepo
      ${pkgs.flatpak}/bin/flatpak update --system -y --noninteractive

      installed="$(${pkgs.flatpak}/bin/flatpak list --app --columns=application --system || true)"

      if [ -n "$installed" ]; then
        for app in $installed; do
          if ! printf '%s' "$declared" | ${pkgs.gnugrep}/bin/grep -F -x -q -- "$app"; then
            ${pkgs.flatpak}/bin/flatpak uninstall --system -y --noninteractive "$app"
          fi
        done
      fi

      while IFS= read -r app; do
        [ -z "$app" ] && continue
        ${pkgs.flatpak}/bin/flatpak install --system -y --noninteractive --app --or-update flathub "$app"
      done <<< "$declared"

      ${pkgs.flatpak}/bin/flatpak uninstall --system --unused -y --noninteractive
      ${pkgs.flatpak}/bin/flatpak update --system -y --noninteractive
    '';
  };
}
