{ ... }:

let
  flatpaks = [
    "io.github.flattool.Warehouse"
    "com.github.tchx84.Flatseal"

    "com.termius.Termius"

    "org.telegram.desktop"
    "com.discordapp.Discord"
    "com.tencent.WeChat"

    "com.spotify.Client"
  ];
in
{
  services.flatpak = {
    enable = true;
    packages = flatpaks;
    uninstallUnused = true;
    update.auto = {
      enable = true;
      onCalendar = "weekly";
    };
  };
}
