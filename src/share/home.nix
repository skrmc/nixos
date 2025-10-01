# /etc/nixos/src/share/home.nix

{
  pkgs,
  colors,
  fonts,
  user,
  ...
}:
{
  home-manager = {
    extraSpecialArgs = { inherit colors fonts; };
    users.${user} = {
      home = {
        stateVersion = "25.05";
        packages = with pkgs; [
          brightnessctl
          hyprpicker
          playerctl
          slurp
          grim
        ];
      };
      imports = [
        ./home/hyprland.nix
        ./home/programs.nix
      ];
      xdg.desktopEntries = {
        btop = {
          name = "Btop";
          noDisplay = true;
        };
        fish = {
          name = "Fish";
          noDisplay = true;
        };
      };
      gtk = {
        enable = true;
        iconTheme = {
          name = "Papirus";
        };
        font = {
          name = fonts.sans;
          size = 10;
        };
      };
      home.pointerCursor = {
        gtk.enable = true;
        # x11.enable = true;
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Classic";
        size = 16;
      };
    };
  };
}
