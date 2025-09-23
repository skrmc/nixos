# /etc/nixos/src/share/default.nix
{
  imports = [
    ./overlays.nix
    ./system.nix
    ./users.nix
    ./home.nix

    ./modules/battery.nix
    ./modules/fonts.nix
    ./modules/neovim.nix
    ./modules/programs.nix
    ./modules/flatpak.nix
  ];
}
