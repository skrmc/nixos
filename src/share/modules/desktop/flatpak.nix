{
  lib,
  user,
  ...
}:

let
  flatpaks = [
    "io.github.flattool.Warehouse"
    "com.github.tchx84.Flatseal"

    "com.termius.Termius"

    "org.telegram.desktop"
    "dev.vencord.Vesktop"
    "com.tencent.WeChat"

    "com.spotify.Client"
  ];
in
{
  xdg.portal.enable = lib.mkForce true;

  services.flatpak = {
    enable = true;
    packages = flatpaks;
    uninstallUnused = true;
    update.auto = {
      enable = true;
      onCalendar = "weekly";
    };
  };

  home-manager.users.${user} = {
    services.flatpak.enable = true;
    services.flatpak.overrides.global.Context = {
      sockets = [ "wayland" ];
      filesystems = [ "xdg-public-share" ];
    };
  };
}
