{ lib, pkgs, ... }:

let
  flatpaks = [
    "com.github.tchx84.Flatseal"
    "com.valvesoftware.Steam"
    "com.discordapp.Discord"
    "com.termius.Termius"
  ];
in
{
  services.flatpak.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-wlr
    ];
    config = {
      common.default = [
        "gtk"
        "wlr"
      ];
    };
  };

  system.activationScripts.flatpakSystemManagement.text = ''
    set -eu

    declared=$'${lib.concatStringsSep "\\n" flatpaks}\n'

    ${pkgs.flatpak}/bin/flatpak remote-add --if-not-exists --system flathub \
      https://flathub.org/repo/flathub.flatpakrepo || true

    installed="$(${pkgs.flatpak}/bin/flatpak list --app --columns=application --system || true)"

    if [ -n "$installed" ]; then
      for app in $installed; do
        if ! printf '%s' "$declared" | ${pkgs.gnugrep}/bin/grep -F -x -q -- "$app"; then
          ${pkgs.flatpak}/bin/flatpak uninstall --system -y --noninteractive "$app" || true
        fi
      done
    fi

    while IFS= read -r app; do
      [ -z "$app" ] && continue
      ${pkgs.flatpak}/bin/flatpak install --system -y flathub "$app" || true
    done <<< "$declared"

    ${pkgs.flatpak}/bin/flatpak uninstall --system --unused -y || true
    ${pkgs.flatpak}/bin/flatpak update --system -y || true
  '';
}
