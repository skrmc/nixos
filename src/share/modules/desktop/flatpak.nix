{
  lib,
  pkgs,
  user,
  ...
}:

let
  flatpaks = [
    "io.github.flattool.Warehouse"
    "com.github.tchx84.Flatseal"

    "org.telegram.desktop"
    "com.tencent.WeChat"
  ];

  ozoneFlatpaks = [
    "com.discordapp.Discord"
    "com.termius.Termius"
    "com.spotify.Client"
  ];
in
{
  xdg.portal.enable = lib.mkForce true;

  services.flatpak = {
    enable = true;
    packages = flatpaks ++ ozoneFlatpaks;
    uninstallUnused = true;
    update.auto = {
      enable = true;
      onCalendar = "weekly";
    };
  };

  system.activationScripts.flatpakOzoneDesktopEntries = {
    deps = [ "users" ];
    text = ''
      patch_ozone_desktop_entry() {
        local app_id="$1"
        local source="/var/lib/flatpak/exports/share/applications/$app_id.desktop"

        [ -f "$source" ] || return 0

        local generated="$(${pkgs.coreutils}/bin/mktemp)"

        ${pkgs.gawk}/bin/awk '
          /^Exec=/ && !/--ozone-platform=wayland/ {
            if (!sub(/ @@/, " --ozone-platform=wayland @@")) {
              $0 = $0 " --ozone-platform=wayland"
            }
          }
          { print }
        ' "$source" > "$generated"

        ${pkgs.coreutils}/bin/install -d -m 0755 -o ${lib.escapeShellArg user} -g users \
          /home/${lib.escapeShellArg user}/.local/share/applications
        ${pkgs.coreutils}/bin/install -d -m 0755 -o root -g root \
          /root/.local/share/applications
        ${pkgs.coreutils}/bin/install -m 0644 -o ${lib.escapeShellArg user} -g users \
          "$generated" "/home/${lib.escapeShellArg user}/.local/share/applications/$app_id.desktop"
        ${pkgs.coreutils}/bin/install -m 0644 -o root -g root \
          "$generated" "/root/.local/share/applications/$app_id.desktop"
        ${pkgs.coreutils}/bin/rm -f "$generated"
      }

      for app_id in ${lib.concatMapStringsSep " " lib.escapeShellArg ozoneFlatpaks}; do
        patch_ozone_desktop_entry "$app_id"
      done
    '';
  };

  home-manager.users.${user} = {
    services.flatpak.enable = true;
    services.flatpak.overrides.global.Context = {
      sockets = [ "wayland" ];
      filesystems = [ "xdg-public-share" ];
    };
  };
}
